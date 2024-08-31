resource "aws_security_group" "alb_sg" {
  name        = "${var.prefix}-sg-alb-${var.environment}"
  description = "Security group for main ALB instance"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.prefix}-sg-alb-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "alb_sg_ingress_https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_sg_egress_all" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}




resource "aws_security_group" "api_sg" {
  name        = "${var.prefix}-sg-api-${var.environment}"
  description = "Security group for API ECS instances"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.prefix}-sg-api-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "api_sg_ingress_alb" {
  security_group_id            = aws_security_group.api_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 8000
  to_port                      = 8000
}

resource "aws_vpc_security_group_ingress_rule" "api_sg_ingress_redis" {
  security_group_id            = aws_security_group.api_sg.id
  referenced_security_group_id = aws_security_group.api_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 6379
  to_port                      = 6379
}

resource "aws_vpc_security_group_egress_rule" "api_sg_egress_all" {
  security_group_id = aws_security_group.api_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}




resource "aws_security_group" "rds_sg" {
  name        = "${var.prefix}-sg-rds-${var.environment}"
  description = "Security group for RDS instances"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.prefix}-sg-rds-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_sg_ingress_api" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.api_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "rds_sg_egress_all" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
