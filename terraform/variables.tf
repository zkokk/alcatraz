variable "vpc_name" {
  default = "main_vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_a" {
  default = "10.0.10.0/24"
}

variable "subnet_cidr_b" {
  default = "10.0.20.0/24"
}

variable "az_a" {
  default = "eu-central-1a"
}

variable "az_b" {
  default = "eu-central-1b"
}

variable "instance_count" {
  default = 2
}

variable "instance_type" {
  default = "t3.micro"
}