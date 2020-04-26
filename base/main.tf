module "network" {
  source             = "./network"
  base_cidr_block    = var.base_cidr_block
  subnet_cidr_blocks = var.instances.*.subnet_cidr_block
  open_port          = var.instance_port
  common_tags        = var.common_tags
}

module "key_pair" {
  source      = "./key_pair"
  public_key  = var.ssh_key.public
  common_tags = var.common_tags
}

module "elb" {
  source        = "./elb"
  vpc_id        = module.network.vpc_id
  subnet_ids    = module.network.subnet_ids
  instance_ids  = aws_instance.node.*.id
  instance_port = var.instance_port
  common_tags   = var.common_tags
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
  count         = length(var.instances)
  key_name      = module.key_pair.key_name
  ami           = data.aws_ami.centos.id
  instance_type = "t2.micro"
  subnet_id     = tolist(module.network.subnet_ids)[count.index]
  user_data     = var.instance_user_data

  tags = var.common_tags
}
