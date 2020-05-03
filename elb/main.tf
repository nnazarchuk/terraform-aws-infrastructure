resource "aws_elb" "main" {
  subnets                   = var.subnets
  security_groups           = var.security_groups
  instances                 = var.instances
  cross_zone_load_balancing = true

  listener {
    instance_port     = var.instance_port
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.instance_port}/"
    interval            = 30
  }

  tags = var.tags
}
