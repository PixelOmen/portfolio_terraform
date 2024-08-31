output "alb_sg" {
  value = aws_security_group.alb_sg
}

output "api_sg" {
  value = aws_security_group.api_sg
}

output "rds_sg" {
  value = aws_security_group.rds_sg
}
