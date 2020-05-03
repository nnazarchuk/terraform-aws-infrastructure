provider "aws" {
  region = var.region
}

resource "aws_key_pair" "main" {
  public_key = file(var.ssh_key.public)

  tags = var.common_tags
}

module "vpc" {
  source       = "../../vpc"
  subnet_count = var.instance_count + 1
  tags         = var.common_tags
}

# Security Groups

module "elb_security_group" {
  source = "../../security_group"
  vpc_id = module.vpc.id
  ingress_rules = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
  tags = var.common_tags
}

module "instance_security_group" {
  source = "../../security_group"
  vpc_id = module.vpc.id
  ingress_rules = [{
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [module.elb_security_group.id]
  }]
  tags = var.common_tags
}

module "jenkins_security_group" {
  source = "../../security_group"
  vpc_id = module.vpc.id
  ingress_rules = [{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
  tags = var.common_tags
}

# Instances

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["aws-marketplace"]
}

resource "aws_instance" "jenkins" {
  key_name                    = aws_key_pair.main.key_name
  ami                         = data.aws_ami.centos.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.subnet_ids[var.instance_count]
  vpc_security_group_ids      = [module.jenkins_security_group.id]
  associate_public_ip_address = true

  tags = merge(
    var.common_tags,
    {
      Service = "jenkins"
      OS      = "CentOS"
    }
  )
}

resource "aws_instance" "node" {
  count                  = var.instance_count
  key_name               = aws_key_pair.main.key_name
  ami                    = data.aws_ami.centos.id
  instance_type          = "t2.micro"
  subnet_id              = tolist(module.vpc.subnet_ids)[count.index]
  vpc_security_group_ids = [module.instance_security_group.id]

  tags = merge(
    var.common_tags,
    {
      Service = "node"
      OS      = "CentOS"
    }
  )
}

# ELB

module "elb" {
  source          = "../../elb"
  security_groups = [module.elb_security_group.id]
  subnets         = module.vpc.subnet_ids
  instances       = aws_instance.node.*.id
  instance_port   = 3000
  tags            = var.common_tags
}
