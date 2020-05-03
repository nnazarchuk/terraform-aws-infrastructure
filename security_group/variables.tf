variable "vpc_id" {}

variable "ingress_rules" {
  type = list

  default = []
}

variable "tags" {
  type = map

  default = {}
}
