resource "aws_ecs_task_definition" "redis_task_definition" {
  family                   = "${var.prefix}_ecs_redis_${var.environment}"
  cpu                      = "256"
  memory                   = "2048"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = <<DEFINITION
    [
        {
            "name": "redis",
            "image": "redis:7.4-alpine",
            "cpu": 128,
            "memory": 2048,
            "portMappings": [
                {
                    "name": "${local.redis_service_port_name}",
                    "containerPort": 6379,
                    "hostPort": 6379,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${var.environment}/ecs/redis",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "${var.environment}/ecs"
                }
            },
            "systemControls": []
        }
    ]
  DEFINITION

  tags = {
    Name        = "${var.prefix}_ecs_redis_${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "api_task_definition" {
  family                   = "${var.prefix}_ecs_django-api_${var.environment}"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = <<DEFINITION
    [
        {
            "name": "django_api",
            "image": "${local.image_name}",
            "cpu": 512,
            "memory": 1024,
            "portMappings": [
                {
                    "containerPort": 8000,
                    "hostPort": 8000,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "command": [
                "sh",
                "-c",
                "gunicorn portfolio_api.wsgi:application --bind 0.0.0.0:8000"
            ],
            "environment": [
                {
                    "name": "DJANGO_SETTINGS_MODULE",
                    "value": "${var.DJANGO_SETTINGS_MODULE}"
                }
            ],
            "environmentFiles": [
                {
                    "value": "${var.env_bucket_arn}/${var.env_filename}",
                    "type": "s3"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${var.environment}/ecs/django_api",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "${var.environment}/ecs"
                }
            },
            "systemControls": []
        }
    ]
  DEFINITION

  tags = {
    Name        = "${var.prefix}_ecs_django-api_${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "celery-beat_task_definition" {
  family                   = "${var.prefix}_ecs_celery-beat_${var.environment}"
  cpu                      = "256"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = <<DEFINITION
    [
        {
            "name": "celery_beat",
            "image": "${local.image_name}",
            "cpu": 256,
            "memory": 1024,
            "portMappings": [],
            "essential": true,
            "command": [
                "sh",
                "-c",
                "celery -A portfolio_api beat --loglevel=info"
            ],
            "environment": [
                {
                    "name": "DJANGO_SETTINGS_MODULE",
                    "value": "${var.DJANGO_SETTINGS_MODULE}"
                }
            ],
            "environmentFiles": [
                {
                    "value": "${var.env_bucket_arn}/${var.env_filename}",
                    "type": "s3"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${var.environment}/ecs/celery_beat",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "${var.environment}/ecs"
                }
            },
            "systemControls": []
        }
    ]
  DEFINITION

  tags = {
    Name        = "${var.prefix}_ecs_celery-beat_${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "celery-worker_task_definition" {
  family                   = "${var.prefix}_ecs_celery-worker_${var.environment}"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = <<DEFINITION
    [
        {
            "name": "celery_worker",
            "image": "${local.image_name}",
            "cpu": 256,
            "memory": 512,
            "portMappings": [],
            "essential": true,
            "command": [
                "sh",
                "-c",
                "celery -A portfolio_api worker --loglevel=info"
            ],
            "environment": [
                {
                    "name": "DJANGO_SETTINGS_MODULE",
                    "value": "${var.DJANGO_SETTINGS_MODULE}"
                }
            ],
            "environmentFiles": [
                {
                    "value": "${var.env_bucket_arn}/${var.env_filename}",
                    "type": "s3"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${var.environment}/ecs/celery_worker",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "${var.environment}/ecs"
                }
            },
            "systemControls": []
        }
    ]
  DEFINITION

  tags = {
    Name        = "${var.prefix}_ecs_celery-worker_${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "django-migrate_task_definition" {
  family                   = "${var.prefix}_ecs_django-migrate_${var.environment}"
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn

  container_definitions = <<DEFINITION
    [
        {
            "name": "django_migrate",
            "image": "${local.image_name}",
            "cpu": 512,
            "memory": 1024,
            "portMappings": [
                {
                    "containerPort": 8000,
                    "hostPort": 8000,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "command": [
                "sh",
                "-c",
                "python manage.py migrate && python manage.py seed_defaults"
            ],
            "environment": [
                {
                    "name": "DJANGO_SETTINGS_MODULE",
                    "value": "${var.DJANGO_SETTINGS_MODULE}"
                }
            ],
            "environmentFiles": [
                {
                    "value": "${var.env_bucket_arn}/${var.env_filename}",
                    "type": "s3"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${var.environment}/ecs/django_migrate",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "${var.environment}/ecs"
                }
            },
            "systemControls": []
        }
    ]
  DEFINITION

  tags = {
    Name        = "${var.prefix}_ecs_django-migrate_${var.environment}"
    Environment = var.environment
  }
}
