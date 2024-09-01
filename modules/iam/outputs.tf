output "execution_role" {
  value = aws_iam_role.ecs_task_execution_role
}

output "task_role" {
  value = aws_iam_role.django_api_task_role
}
