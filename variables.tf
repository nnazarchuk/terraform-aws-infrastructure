variable "instance_count" {
  type = number

  default = 1
}

variable "common_tags" {
  type = map

  default = {
    Service = "Terraform"
  }
}
