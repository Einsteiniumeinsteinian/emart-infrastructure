# frontend load balancer
resource "aws_lb" "frontend_alb" {
  name               = "${var.tags.name}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${module.custom_vpc_config.vpc.public_subnet_id[0]}", "${module.custom_vpc_config.vpc.public_subnet_id[1]}"] # Replace with your subnet IDs
  security_groups    = [module.custom_vpc_config.vpc.security_group_id[1]]
  depends_on = [
    module.custom_vpc_config,
  ]
  tags = {
    Name = "${var.tags.name}-Frontend-Aplication-Load-Balancer"
    environment : var.tags.environment
  }
}

resource "aws_lb_listener" "frontend_alb_http_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  tags = {
    Name = "${var.tags.name}-frontend-http-listener"
    environment : var.tags.environment
  }
}

resource "aws_lb_listener" "frontend_alb_https_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }

  depends_on = [aws_acm_certificate.cert]

  tags = {
    Name = "${var.tags.name}-frontend-https-listener"
    environment : var.tags.environment
  }
}

resource "aws_lb_target_group" "frontend_target_group" {
  name     = "frontend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.custom_vpc_config.vpc.vpc_id

  tags = {
    Name = "${var.tags.name}-frontend-target-group"
    environment : var.tags.environment
  }
}