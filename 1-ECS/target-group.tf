# Load balancer target group
resource "aws_lb_target_group" "target_group" {
  name        = var.alb-target
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  # health_check {
  #   healthy_threshold   = "3"
  #   interval            = "300"
  #   protocol            = "HTTP"
  #   matcher             = "200"
  #   timeout             = "3"
  #   path                = "/v1/status"
  #   unhealthy_threshold = "2"
  # }

  tags = {
    Name        = var.alb-target
  }
}