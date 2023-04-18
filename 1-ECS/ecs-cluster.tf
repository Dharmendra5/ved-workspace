# ECS cluster creation
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster-name
  tags = {
   name = var.cluster-name
  }
}
