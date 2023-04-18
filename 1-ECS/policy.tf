# Policies query
data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
  actions = ["sts:AssumeRole"]
  principals {
  type = "Service"
  identifiers = ["ec2.amazonaws.com"]
  }
 }
}

data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
  actions = ["sts:AssumeRole"]
  principals {
  type = "Service"
  identifiers = ["ecs.amazonaws.com"]
  }
 }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
