module "base" {
  source         = "./base"
  instance_count = var.instance_count
  common_tags    = var.common_tags
}
