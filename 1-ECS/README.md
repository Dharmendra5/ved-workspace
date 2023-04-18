# Purpose
- This code helps to create Elastic container service (ECS) in AWS to run docker containers.

# File structure

## Load balancer creation files
- `alb.tf`           : Creates application load balancer
- `listener.tf`      : Creates listener for load balancer
- `target-group`     : Creates target group for load balancer

## ECS cluster creation files
- `ecs-cluster.tf`       : Creates ECS cluster in AWS
- `ecs-service.tf`       : Creates ECS service in AWS
- `ecs-tasks.tf`         : Creates tasks in AWS
- `task_definition.json` : Define image informations for ECS cluster

## Network setup for ECS cluser
- `network.tf` : Creates VPC and Subnets for ECS cluster in AWS
- `sgroup.tf`  : Creates Security group for load balancer and ECS cluster
- `role.tf`    : Creates required role for ECS and EC2
- `policy.tf`  : Creates required policies for ECS and EC2

## EC2 instance creation for ECS cluster
- `ec2-instance.tf` : Creates EC2 and attach with ECS cluster
- `user_data.tpl`   : Does bootsrapping for EC2 to attach it with ECS cluster

## Monitoring
- `cloudwatch.tf`  : Creates cloudwatch log group for ECS cluster

## Other files
- `variable.tf`      : Declared variables in this file
- `output.tf`        : Load balancer DNS names to output
- `terraform.tfvars` : Define values for decalred variables

# How to implement
- Makesure you have aws access & secret key added as env file using awscli
- Change to be made in `terraform.tfvars` file
    - `region`
    - `azs`
    - `ami`
- Apply code : `terraform apply`