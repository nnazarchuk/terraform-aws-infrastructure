variable "region" {
  default = "us-east-1"
}

variable "common_tags" {}

variable "ssh_key" {
  type = object({ private = string, public = string })

  default = {
    private = "~/.ssh/terraform"
    public  = "~/.ssh/terraform.pub"
  }
}

variable "base_cidr_block" {
  default = "192.168.123.0/24"
}

variable "instance_count" {
  type = number

  default = 1
}

variable "instance_port" {
  type = number

  default = 9000
}

variable "user_data" {
  default = ""
}
