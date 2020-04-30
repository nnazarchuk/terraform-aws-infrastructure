module "base" {
  source         = "./base"
  instance_count = var.instance_count
  instance_port  = var.instance_port
  common_tags    = var.common_tags
}
