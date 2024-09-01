locals {
  full_cluster_name       = "${var.prefix}-${var.api_cluster_name}-${var.environment}"
  full_repo_name          = "${var.prefix}_${var.ecr_repo_name}_${var.environment}"
  migrate_task_name       = "${var.prefix}_${var.migrate_task_name}_${var.environment}"
  image_name              = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${local.full_repo_name}:latest"
  redis_service_port_name = "ecs-service-redis"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = local.full_cluster_name

  tags = {
    Name        = local.full_cluster_name
    Environment = var.environment
  }
}

resource "aws_ecs_service" "redis_service" {
  name            = "${var.prefix}-ecs-service-redis-${var.environment}"
  cluster         = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.redis_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.api_sg_id]
    assign_public_ip = false
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  service_connect_configuration {
    enabled   = true
    namespace = local.full_cluster_name

    service {
      port_name = local.redis_service_port_name
      client_alias {
        port = 6379
      }
    }
  }

  tags = {
    Name        = "${var.prefix}-ecs-service-redis-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "django_api_service" {
  name                              = "${var.prefix}-ecs-service-django_api-${var.environment}"
  cluster                           = aws_ecs_cluster.ecs_cluster.arn
  task_definition                   = aws_ecs_task_definition.api_task_definition.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 60

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.api_sg_id]
  }

  load_balancer {
    target_group_arn = var.django_api_tg_arn
    container_name   = "django_api"
    container_port   = 8000
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  service_connect_configuration {
    enabled   = true
    namespace = local.full_cluster_name
  }

  tags = {
    Name        = "${var.prefix}-ecs-service-django_api-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "celery_beat_service" {
  name            = "${var.prefix}-ecs-service-celery_beat-${var.environment}"
  cluster         = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.celery-beat_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.api_sg_id]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  service_connect_configuration {
    enabled   = true
    namespace = local.full_cluster_name
  }

  tags = {
    Name        = "${var.prefix}-ecs-service-celery_beat-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "celery_worker_service" {
  name            = "${var.prefix}-ecs-service-celery_worker-${var.environment}"
  cluster         = aws_ecs_cluster.ecs_cluster.arn
  task_definition = aws_ecs_task_definition.celery-worker_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.api_sg_id]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  service_connect_configuration {
    enabled   = true
    namespace = local.full_cluster_name
  }

  tags = {
    Name        = "${var.prefix}-ecs-service-celery_worker-${var.environment}"
    Environment = var.environment
  }
}
