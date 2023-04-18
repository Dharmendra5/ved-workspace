# Application load balancer
resource "aws_alb" "alb" {
  name               = var.alb-name
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.lb.id]

  tags = {
    Name        = var.alb-name
  }
}