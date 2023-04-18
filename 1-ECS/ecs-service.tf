# ECS service
resource "aws_ecs_service" "service" {
  cluster                = aws_ecs_cluster.cluster.id
  desired_count          = 1                                                      
  launch_type            = "EC2"                                               
  name                   = var.ecs-service-name                    
  task_definition        = aws_ecs_task_definition.task_definition.arn  
  load_balancer {
    container_name       = var.container-name                             
    container_port       = "8080"
    target_group_arn     = aws_lb_target_group.target_group.arn    
 }
  network_configuration {
    security_groups       = [aws_security_group.my_sg.id]
    subnets               = aws_subnet.private.*.id
    assign_public_ip      = "false"
  }
  depends_on              = [aws_lb_listener.listener]
}