resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block

  tags = var.common_tags
}

resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = var.instance_port
    to_port     = var.instance_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
      "Name", "Default Security group"
    )
  )
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.main.id

  tags = var.common_tags
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "instance_subnet" {
  count             = length(var.subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = var.common_tags
}
