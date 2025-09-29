output "amazon_ami_id" {
  value = data.aws_ami.amazon.id
}

output "alb_dns" {
  value = data.aws_lb.flask_alb.dns_name
}