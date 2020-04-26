provider "aws" {
  region = var.region
}

module "key_pair" {
  source      = "./key_pair"
  public_key  = var.ssh_key.public
  common_tags = var.common_tags
}

module "security" {
  source        = "./security"
  vpc_id        = module.vpc.id
  instance_port = var.instance_port
  common_tags   = var.common_tags
}

module "vpc" {
  source          = "./vpc"
  instance_count  = var.instance_count
  base_cidr_block = var.base_cidr_block
  common_tags     = var.common_tags
}

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

resource "aws_instance" "node" {
  count                       = var.instance_count
  key_name                    = module.key_pair.key_name
  ami                         = data.aws_ami.centos.id
  instance_type               = "t2.micro"
  subnet_id                   = tolist(module.vpc.subnet_ids)[count.index]
  vpc_security_group_ids      = [module.security.instance_security_group_id]
  user_data                   = var.user_data
  associate_public_ip_address = true

  tags = var.common_tags
}

module "elb" {
  source            = "./elb"
  security_group_id = module.security.elb_security_group_id
  subnet_ids        = module.vpc.subnet_ids
  instance_ids      = aws_instance.node.*.id
  instance_port     = var.instance_port
  common_tags       = var.common_tags
}
