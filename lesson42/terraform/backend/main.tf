resource "aws_s3_bucket" "backend_bucket" {
    bucket = "tms-dos11-terraform-backend"

    tags = {
        Name        = "tms-dos11"
    }
}

resource "aws_s3_bucket_acl" "backend_bucket_acl" {
    bucket = aws_s3_bucket.backend_bucket.id
    acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
    bucket = aws_s3_bucket.backend_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

# resource "aws_dynamodb_table" "dynamodb-table" {
#   name           = "terraform-backend-lock"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 1
#   write_capacity = 1
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "tms-dos11"
#   }
# }
