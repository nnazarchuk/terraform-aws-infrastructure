resource "aws_security_group" "elb" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    map(
      "Name", "ELB security group"
    )
  )
}

resource "aws_elb" "main" {
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.elb.id]
  instances                   = var.instance_ids
  cross_zone_load_balancing   = true

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

  tags = var.common_tags
}
