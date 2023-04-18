# Purpose
- This code helps to create Elastic container Registry (ECR) in AWS to store application docker image.

# File structure
- `ecr.tf`           : Creates ECR private repo in AWS
- `policy.tf`        : Apply required policies to ECR repo
- `provider.tf`      : AWS provider
- `variable.tf`      : Decalred variables
- `terraform.tfvars` : Declared values for variables

# How to implement
- Just change the desired region and your repo name in `terraform.tfvars` file
- Apply code : `terraform apply`