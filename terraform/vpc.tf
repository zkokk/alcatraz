# VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = var.vpc_name
  }
}


# Subnets
resource "aws_default_subnet" "a_subnet" {
  availability_zone = var.az_a

  tags = {
    Name = "subnet-a"
  }
}

resource "aws_default_subnet" "b_subnet" {
  availability_zone = var.az_b

  tags = {
    Name = "subnet-b"
  }
}
