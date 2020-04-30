variable "instance_count" {
  type = number

  default = 1
}

variable "instance_port" {
  type = number

  default = 3000
}

variable "common_tags" {
  type = map

  default = {}
}
