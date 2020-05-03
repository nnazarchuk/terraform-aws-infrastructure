output "elb_dns" {
  value = module.elb.dns_name
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
