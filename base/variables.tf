variable "common_tags" {
  type = map

  default = {
    Service = "Terraform"
    Owner   = "Nikita Nazarchuk"
  }
}

variable "base_cidr_block" {
  default = "192.168.123.0/24"
}

variable "instance_port" {
  default = 9000
}

variable "instance_user_data" {
  default = ""
}

variable "instances" {
  type = list(object({ subnet_cidr_block = string }))

  default = [
    {
      instance_type     = "t2.micro",
      subnet_cidr_block = "192.168.123.0/28"
    },
    {
      instance_type     = "t2.micro",
      subnet_cidr_block = "192.168.123.16/28"
    }
  ]
}

variable "ssh_key" {
  type = object({ private = string, public = string })

  default = {
    private = "~/.ssh/terraform"
    public  = "~/.ssh/terraform.pub"
  }
}
