# Get the default VPC in the region
data "aws_vpc" "default" {
  default = true

  tags = {
    Name = var.vpc_name
  }
}

# Get all subnets in that VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}