output "id" {
  value = aws_vpc.common.id
}

output "subnet_ids" {
  value = aws_subnet.instance_subnet.*.id
}
