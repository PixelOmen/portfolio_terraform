resource "aws_cloudwatch_log_group" "redis_log_group" {
  name              = "${var.environment}/ecs/redis"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "api_log_group" {
  name              = "${var.environment}/ecs/django_api"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "celery_beat_log_group" {
  name              = "${var.environment}/ecs/celery_beat"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "celery_worker_log_group" {
  name              = "${var.environment}/ecs/celery_worker"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "django_migrate_log_group" {
  name              = "${var.environment}/ecs/django_migrate"
  retention_in_days = 7
}
