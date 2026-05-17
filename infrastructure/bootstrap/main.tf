# S3 Bucket to house remote .tfstate configurations
resource "aws_s3_bucket" "state_bucket" {
  bucket        = "eventpulse-terraform-state-2026" # Ensure this is globally unique
  force_destroy = false

  tags = {
    Name        = "EventPulse Terraform State Storage"
    Environment = "Bootstrap"
  }
}

# Versioning is critical to guarantee state history & recovery
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# At-rest encryption for the sensitive state values
resource "aws_s3_bucket_server_side_encryption_configuration" "state_encryption" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# DynamoDB table to handle concurrent write locking 
resource "aws_dynamodb_table" "lock_table" {
  name         = "eventpulse-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "EventPulse State Lock Table"
    Environment = "Bootstrap"
  }
}
