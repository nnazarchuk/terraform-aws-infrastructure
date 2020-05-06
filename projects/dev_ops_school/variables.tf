variable "region" {
  default = "us-east-1"
}

variable "instance_count" {
  type = number

  default = 1
}

variable "common_tags" {
  type = map

  default = {
    Project = "devOpsSchool"
    Owner   = "Nikita Nazarchuk"
  }
}

variable "ssh_key" {
  type = object({ private = string, public = string })

  default = {
    private = "~/.ssh/terraform"
    public  = "~/.ssh/terraform.pub"
  }
}
