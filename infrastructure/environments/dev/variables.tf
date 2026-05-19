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

# --- Added Missing Root Network Declarations with Defaults ---
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "eventpulse-dev-vpc"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# --- Cleaning Up Remaining tfvars Warnings ---
variable "cluster_name" {
  type        = string
  description = "Name of the ECS compute cluster"
  default     = "eventpulse-dev-cluster"
}

variable "stream_name" {
  type        = string
  description = "Kinesis data stream name for incoming real-time sports metrics"
  default     = "eventpulse-sports-metrics-stream"
}

variable "function_name" {
  type        = string
  description = "Target Lambda function name for data processing"
  default     = "eventpulse-data-processor"
}

# --- Additional tfvars Syncing ---
variable "environment" {
  type        = string
  description = "Target deployment stage (e.g., dev, prod)"
  default     = "dev"
}

variable "rule_name" {
  type        = string
  description = "EventBridge rule name for microservice polling"
  default     = "eventpulse-service-polling-rule"
}

# Catch-all for the remaining 2 variables hidden in your tfvars file
variable "lambda_handler" {
  type    = string
  default = "index.handler"
}

variable "lambda_runtime" {
  type    = string
  default = "nodejs18.x"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for state or media assets"
  default     = "eventpulse-assets-dev-bucket"
}

variable "repo_names" {
  type        = list(string)
  description = "List of ECR repository names from tfvars"
  default     = ["score-service", "athlete-service", "leaderboard-service"]
}
