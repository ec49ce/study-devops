# aws_instance.app:
resource "aws_instance" "app" {
    ami                                  = "ami-03e08697c325f02ab"
    associate_public_ip_address          = true
    availability_zone                    = "eu-central-1a"
    cpu_core_count                       = 1
    cpu_threads_per_core                 = 1
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    get_password_data                    = false
    hibernation                          = false
    instance_initiated_shutdown_behavior = "stop"
    instance_type                        = "t2.micro"
    key_name                             = "raguzin_frankfurt_key"
    monitoring                           = false
    placement_partition_number           = 0
    private_ip                           = "172.31.27.202"
    secondary_private_ips                = []
    security_groups                      = [
        "launch-wizard-1",
    ]
    source_dest_check                    = true
    subnet_id                            = "subnet-024bf1638f8c934a0"
    tags                                 = {
        "Name" = "demo"
    }
    tags_all                             = {
        "Name" = "demo"
    }
    tenancy                              = "default"
    vpc_security_group_ids               = [
        "sg-06e3d85a6edd4fec0",
    ]

    capacity_reservation_specification {
        capacity_reservation_preference = "open"
    }

    credit_specification {
        cpu_credits = "standard"
    }

    enclave_options {
        enabled = false
    }

    maintenance_options {
        auto_recovery = "default"
    }

    metadata_options {
        http_endpoint               = "enabled"
        http_put_response_hop_limit = 1
        http_tokens                 = "optional"
        instance_metadata_tags      = "disabled"
    }

    private_dns_name_options {
        enable_resource_name_dns_a_record    = true
        enable_resource_name_dns_aaaa_record = false
        hostname_type                        = "ip-name"
    }

    # root_block_device {
    #     delete_on_termination = true
    #     device_name           = "/dev/sda1"
    #     encrypted             = false
    #     iops                  = 100
    #     tags                  = {}
    #     throughput            = 0
    #     volume_id             = "vol-0619986f9979c9b78"
    #     volume_size           = 8
    #     volume_type           = "gp2"
    # }

    timeouts {}
}
