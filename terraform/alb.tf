resource "aws_security_group" "https" {
  name        = "alb"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_lb" "skillpact_alb" {
  name               = "skillpact-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.https.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.skillpact_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.skillpact_app_tg.arn
  }

  ssl_policy      = "ELBSecurityPolicy-2016-08" # Use an appropriate SSL policy
  certificate_arn = var.acm_ssl_arn
}

resource "aws_lb_listener_certificate" "skillpact" {
  listener_arn    = aws_lb_listener.front_end.arn
  certificate_arn = var.acm_ssl_arn
}

resource "aws_lb_target_group" "skillpact_app_tg" {
  name     = "skillpact-app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check {
    enabled             = true
    interval            = 30
    path                = "/api/health"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200"
  }
}
