resource "aws_vpc" "common" {
  cidr_block = var.base_cidr_block

  tags = var.tags
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.common.id

  tags = var.tags
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.common.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.common.id
  cidr_block        = cidrsubnet(var.base_cidr_block, 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = var.tags
}
