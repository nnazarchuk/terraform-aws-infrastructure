output "instance_public_ips" {
  value = aws_instance.node.*.public_ip
}

output "elb_dns" {
  value = module.elb.dns_name
}
