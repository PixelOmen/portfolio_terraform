
resource "aws_lb_target_group" "django_api_tg" {
  name        = "${var.prefix}-django-api-tg-${var.environment}"
  target_type = "ip"
  protocol    = "HTTP"
  port        = 8000
  vpc_id      = var.vpc_id

  health_check {
    enabled = true
    path    = "/health/"
  }

  tags = {
    Name        = "${var.prefix}-django-api-tg-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_alb" "django_api_alb" {
  name               = "${var.prefix}-django-api-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_ids
  subnets            = var.alb_subnet_ids

  tags = {
    Name        = "${var.prefix}-django-api-alb-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "api_listener_http" {
  load_balancer_arn = aws_alb.django_api_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name        = "${var.prefix}-django-api-http-listener-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "api_listener_https" {
  load_balancer_arn = aws_alb.django_api_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_alb_cert_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      status_code  = "403"
      content_type = "text/plain"
      message_body = "Access Denied"
    }
  }

  tags = {
    Name        = "${var.prefix}-django-api-https-listener-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_lb_listener_rule" "api_listener_https_cf_header_rule" {
  listener_arn = aws_lb_listener.api_listener_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.django_api_tg.arn
  }

  condition {
    http_header {
      http_header_name = var.custom_header_name
      values           = [var.custom_header_value]
    }
  }

  tags = {
    Name        = "${var.prefix}-django-api-https-header-rule-${var.environment}"
    Environment = var.environment
  }

}
