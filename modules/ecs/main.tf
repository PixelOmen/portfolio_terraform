locals {
  cluster_name            = "${var.prefix}-${var.api_cluster_name}-${var.environment}"
  repo_name               = "${var.prefix}_${var.ecr_repo_name}_${var.environment}"
  migrate_task_name       = "${var.prefix}_${var.migrate_task_name}_${var.environment}"
  image_name              = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${local.repo_name}:latest"
  redis_service_port_name = "ecs-service-redis"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.cluster_name

  tags = {
    Name        = local.cluster_name
    Environment = var.environment
  }
}


