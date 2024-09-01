output "alb" {
  value = aws_alb.django_api_alb
}

output "django_api_tg" {
  value = aws_lb_target_group.django_api_tg
}
