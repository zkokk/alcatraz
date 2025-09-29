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
  public_key = file("ec2-ssh-key.pub")
}


# EC2 instances
resource "aws_instance" "app_nodes" {
  count                       = var.instance_count
  ami                         = data.aws_ami.amazon.id
  instance_type               = var.instance_type
  associate_public_ip_address = True
  key_name                    = aws_key_pair.ec2_ssh_key.key_name
  security_groups             = [aws_security_group.flask_sg]
  subnet_id                   = element([aws_default_subnet.a_subnet.id, aws_default_subnet.b_subnet.id], count.index)

  tags = {
    Name = "Web-App-Node-${count.index + 1}"
  }
}

