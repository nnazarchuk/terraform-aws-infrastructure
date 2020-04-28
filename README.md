# DevOps School Infrastructure

It contains simple IaC configuration based on Terraform that can create AWS EC2 instances with and Elastic Load Balancer that balances traffic between this instances.

## Preparation steps
You have to create a SSH key pair to be able to connect to your EC2 instances
`ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/terraform`

Also you need to export AWS environment variables to terraform would have access to your Cloud
https://www.terraform.io/docs/providers/aws/index.html#environment-variables

## Launching
Install terraform on your local machine and run the next commands to create the infrastructure:
```
$ terraform init
$ terraform plan [-var="instance_count=<number>]
$ terraform apply [-var="instance_count=<number>]
```
