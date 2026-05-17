data "aws_caller_identity" "current" {}

# Foundational Core Network Layout
module "vpc" {
  source = "../../modules/vpc"
}

# Shared Security Group configurations
module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

# Global Execution/Task Role Manifests
module "iam" {
  source = "../../modules/iam"
}

# The 3 Automated ECR Registries
module "ecr" {
  source = "../../modules/ecr"
}

# Core Compute cluster orchestration
module "ecs" {
  source            = "../../modules/ecs"
  vpc_id            = module.vpc.vpc_id
  private_subnets   = module.vpc.private_subnets
  public_subnets    = module.vpc.public_subnets
  security_group_id = module.security.ecs_tasks_sg_id
  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  aws_account_id    = data.aws_caller_identity.current.account_id
  aws_region        = var.aws_region

  # Injecting the Jenkins application image versions down into the module execution block
  score_image_tag       = var.score_image_tag
  athlete_image_tag     = var.athlete_image_tag
  leaderboard_image_tag = var.leaderboard_image_tag
}
