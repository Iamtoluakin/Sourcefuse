
resource "aws_lb" "alb" {
  name                       = "sourcefuse-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sourcefuse_sg.id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "sourcefuse-alb"
  }
}
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sourcefuse_vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
  }
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}
