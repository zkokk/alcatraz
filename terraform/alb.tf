# ALB
resource "aws_lb" "flask_alb" {
  name               = "flask-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  #  subnets            = [aws_default_subnet.a_subnet.]
}

resource "aws_lb_target_group" "flask_tg" {
  name     = "flask-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default.id

  health_check {
    path                = "/api/ping"
    port                = "8080"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.flask_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "flask_tg_attach" {
  count            = 2
  target_group_arn = aws_lb_target_group.flask_tg.arn
  target_id        = aws_instance.app_nodes[count.index].id
  port             = 8080
}
