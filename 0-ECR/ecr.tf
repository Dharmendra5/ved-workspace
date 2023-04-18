# Create ECR Repo
resource "aws_ecr_repository" "repository" {
  name                 = var.repo-name
  image_tag_mutability = "IMMUTABLE"
}
