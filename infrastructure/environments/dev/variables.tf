variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# Dynamic variables injected natively by your application Jenkinsfile
variable "score_image_tag" {
  type        = string
  description = "Dynamic build tag for the score microservice"
  default     = "latest"
}

variable "athlete_image_tag" {
  type        = string
  description = "Dynamic build tag for the athlete microservice"
  default     = "latest"
}

variable "leaderboard_image_tag" {
  type        = string
  description = "Dynamic build tag for the leaderboard microservice"
  default     = "latest"
}

# --- Added Missing Root Network Declarations ---
variable "vpc_cidr" { type = string }
variable "vpc_name" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "azs" { type = list(string) }

# --- Cleaning Up Remaining tfvars Warnings ---
variable "cluster_name" {
  type        = string
  description = "Name of the ECS compute cluster"
}

variable "stream_name" {
  type        = string
  description = "Kinesis data stream name for incoming real-time sports metrics"
  default     = ""
}

variable "function_name" {
  type        = string
  description = "Target Lambda function name for data processing"
  default     = ""
}

# --- Additional tfvars Syncing ---
variable "environment" {
  type        = string
  description = "Target deployment stage (e.g., dev, prod)"
}

variable "rule_name" {
  type        = string
  description = "EventBridge rule name for microservice polling"
  default     = ""
}

# Catch-all for the remaining 2 variables hidden in your tfvars file
variable "lambda_handler" {
  type    = string
  default = ""
}

variable "lambda_runtime" {
  type    = string
  default = ""
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for state or media assets"
  default     = ""
}

variable "repo_names" {
  type        = list(string)
  description = "List of ECR repository names from tfvars"
  default     = []
}