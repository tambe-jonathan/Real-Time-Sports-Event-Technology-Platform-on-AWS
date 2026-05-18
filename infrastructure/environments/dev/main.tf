data "aws_caller_identity" "current" {}

# Foundational Core Network Layout
module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_name        = var.vpc_name
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

# Shared Security Group configurations
module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

# Global Execution/Task Role Manifests
module "iam" {
  source    = "../../modules/iam"
  role_name = "eventpulse-ecs-execution-role"
}

# The 3 Automated ECR Registries
module "ecr" {
  source     = "../../modules/ecr"
  repo_names = ["score-service", "athlete-service", "leaderboard-service"]
}

# Core Compute cluster orchestration
module "ecs" {
  source             = "../../modules/ecs"
  cluster_name       = "eventpulse-dev-cluster"
  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  public_subnets     = module.vpc.public_subnets
  security_group_id = module.security.security_group_id
  execution_role_arn = module.iam.role_arn # Fixed to match child output attribute
  task_role_arn      = module.iam.role_arn # Fixed to match child output attribute
  aws_account_id     = data.aws_caller_identity.current.account_id
  aws_region         = var.aws_region

  # Injecting the Jenkins application image versions down into the module execution block
  score_image_tag       = var.score_image_tag
  athlete_image_tag     = var.athlete_image_tag
  leaderboard_image_tag = var.leaderboard_image_tag
}