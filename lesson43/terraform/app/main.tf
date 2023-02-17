data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate"
    }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_key_pair" "selected" {
  key_name = "raguzin_frankfurt_key"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "SSH from all"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description      = "HTTP from all"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  key_name =   data.aws_key_pair.selected.key_name
  instance_type = "t2.micro"
  subnet_id = data.terraform_remote_state.network.outputs.public_subnets[0]
  security_groups = [aws_security_group.allow_http.id, aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  provisioner "local-exec" {
    working_dir = "../../ansible/"
    command = "sleep 90 && ansible-playbook apache.yaml -i '${self.public_ip},' -u ubuntu --private-key ~/.ssh/raguzin_frankfurt_key.pem"
  }

  tags = {
    Name = "dos11"
  }
}