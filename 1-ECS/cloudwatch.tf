resource "aws_cloudwatch_log_group" "log_group" {
  name = var.cloudwatch-name
    tags = {
    Environment = "Test"
  }
}