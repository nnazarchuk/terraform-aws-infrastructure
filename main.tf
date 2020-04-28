module "base" {
  source         = "./base"
  user_data      = var.user_data
  instance_count = var.instance_count
}
