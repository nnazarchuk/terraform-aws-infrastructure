variable "region" {
  default = "us-east-1"
}

variable "common_tags" {
  type = map

  default = {}
}

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
}

variable "instance_port" {
  type = number
}

variable "user_data" {
  default = ""
}
