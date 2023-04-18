# ECS VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.32.0.0/16"
  tags = {
    name = var.vpc-name
  }
}

# Private subnet to host ecs cluster
resource "aws_subnet" "private" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 2 + count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id            = aws_vpc.vpc.id
  tags = {
    name = var.subnet-name-private
  }
}

# First public subnet for load balancer
resource "aws_subnet" "public" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 10, 3 + count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id            = aws_vpc.vpc.id
  tags = {
    name =  var.subnet-name-public
  }
}

# Internet gateway for public subnet
resource "aws_internet_gateway" "ecs_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.igw
  }
}

# Route table for main VPC with igw
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ecs_igw.id
}

# Route table for public subnet with igw
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_igw.id
  }
  tags = {
    Name = var.route
  }
}

# EIP creation for Nat gateway
resource "aws_eip" "gateway" {
  count      = 2
  vpc        = true
  depends_on = [aws_internet_gateway.ecs_igw]
  tags = {
    Name = var.eip
  }
}

# Nat gateway creation
resource "aws_nat_gateway" "gateway" {
  count         = 2
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.gateway.*.id, count.index)
  tags = {
    Name = var.nat
  }
}

# Private route table attached with Nat
resource "aws_route_table" "private" {
  count = 2
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gateway.*.id, count.index)
  }
  tags = {
    Name = var.route-table
  }
}

# Private route table association
resource "aws_route_table_association" "private" {
  count = 2
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

# Public route table association
resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}
