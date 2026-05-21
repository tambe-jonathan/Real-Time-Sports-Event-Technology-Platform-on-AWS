terraform {
  backend "s3" {
    bucket         = "eventpulse-terraform-state-2026"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eventpulse-terraform-locks"
    encrypt        = true
  }
}
