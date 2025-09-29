# Amazon ami id
data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.8.20250915.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

# SSH Key
resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = "ec2-ssh-key"
  public_key = file("../ec2-ssh-key.pub")
}


# EC2 instances
resource "aws_instance" "app_nodes" {
  count                       = var.instance_count
  ami                         = data.aws_ami.amazon.id
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2_ssh_key.key_name
  security_groups             = [aws_security_group.flask_sg.id]
  subnet_id                   = data.aws_subnets.default.ids[count.index]

  tags = {
    Name = "Web-App-Node-${count.index + 1}"
  }
}

