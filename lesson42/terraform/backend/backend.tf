# terraform {
#   backend "s3" {
#     bucket = "tms-dos11-terraform-backend"
#     key    = "s3_bucket/terraform.tfstate"
#     region = "eu-central-1"
#     # dynamodb_table = "terraform-backend-lock"
#   }
# }