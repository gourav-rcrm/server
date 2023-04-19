provider "aws" {
  region = "us-east-2"
}

resource "aws_lb" "ohio_lb" {
  name               = "ohio-lb"
  internal           = false
  load_balancer_type = "application"

  enable_deletion_protection = true

  tags = {
    Name = "ohio-lb"
  }
}

resource "aws_lb_target_group" "ohio_tg" {
  name        = "ohio-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
    port                = 80
  }

  tags = {
    Name = "ohio-tg"
  }
}

resource "aws_lb_listener" "ohio_listener" {
  load_balancer_arn = aws_lb.ohio_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ohio_tg.arn
  }
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "alb_sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}
