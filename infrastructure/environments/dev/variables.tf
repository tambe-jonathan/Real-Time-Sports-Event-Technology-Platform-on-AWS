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
