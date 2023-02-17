variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "tags" {
  type = map
  default = {
    Project = "tms-wordpress"
    Name = "dos11"
    Terraform = true
  }
}