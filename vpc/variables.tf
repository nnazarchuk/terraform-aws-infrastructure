variable "subnet_count" {}

variable "base_cidr_block" {
  default = "192.168.123.0/24"
}

variable "tags" {
  type = map

  default = {}
}
