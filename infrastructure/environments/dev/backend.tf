terraform {
  backend "s3" {
    bucket         = "eventpulse-terraform-state-2026" # Must match bootstrap bucket
    key            = "dev/eventpulse-infra.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eventpulse-terraform-locks"       # Must match bootstrap lock table
    encrypt        = true
  }
}
