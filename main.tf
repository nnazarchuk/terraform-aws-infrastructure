module "base" {
  source         = "./base"
  instance_count = var.instance_count
  user_data      = var.user_data
  common_tags    = var.common_tags
}
