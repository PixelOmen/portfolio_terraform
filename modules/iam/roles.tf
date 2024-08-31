resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.prefix}-ecs-task-execution-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role_document.json

  inline_policy {
    name   = "${var.prefix}-ecs-tasks-execution-policy-${var.environment}"
    policy = data.aws_iam_policy_document.ecs_tasks_execution_document.json
  }

  tags = {
    Name        = "${var.prefix}-ecs-task-execution-role-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_role" "django_api_task_role" {
  name               = "${var.prefix}-django-api-task-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role_document.json

  inline_policy {
    name   = "${var.prefix}-django-api-media-bucket-policy-${var.environment}"
    policy = data.aws_iam_policy_document.media_bucket_document.json
  }

  tags = {
    Name        = "${var.prefix}-django-api-task-role-${var.environment}"
    Environment = var.environment
  }
}
