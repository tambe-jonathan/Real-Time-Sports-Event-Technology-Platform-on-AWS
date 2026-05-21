resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Centralized Log Group for all Microservices
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/eventpulse-dev"
  retention_in_days = 7
}

# 1. SCORE MICROSERVICE
resource "aws_ecs_task_definition" "score" {
  family                   = "score-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "score-container"
      image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/score-service:${var.score_image_tag}"
      essential = true
      portMappings = [{ containerPort = 8080, hostPort = 8080 }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "score"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "score" {
  name            = "score-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.score.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.security_group_id]
    assign_public_ip = false
  }
}

# 2. ATHLETE MICROSERVICE
resource "aws_ecs_task_definition" "athlete" {
  family                   = "athlete-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "athlete-container"
      image = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/athlete-service:${var.athlete_image_tag}"
      essential = true
      portMappings = [{ containerPort = 8081, hostPort = 8081 }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "athlete"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "athlete" {
  name            = "athlete-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.athlete.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.security_group_id]
    assign_public_ip = false
  }
}

# 3. LEADERBOARD MICROSERVICE
resource "aws_ecs_task_definition" "leaderboard" {
  family                   = "leaderboard-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "leaderboard-container"
      image = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/leaderboard-service:${var.leaderboard_image_tag}"
      essential = true
      portMappings = [{ containerPort = 8082, hostPort = 8082 }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "leaderboard"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "leaderboard" {
  name            = "leaderboard-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.leaderboard.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.security_group_id]
    assign_public_ip = false
  }
}