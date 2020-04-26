output "elb_security_group_id" {
  value = aws_security_group.elb.id
}

output "instance_security_group_id" {
  value = aws_security_group.instance.id
}
