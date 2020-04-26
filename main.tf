locals {
  user_data = file("./user_data/install.sh")
}

module "base" {
  source         = "./base"
  user_data      = local.user_data
  instance_count = 2
}
