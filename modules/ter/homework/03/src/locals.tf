locals {
  company     = "netology"
  platform    = "develop-platform"
  web_name    = "web"
  db_name     = "db"
  vm_web_name = "${local.company}-${local.platform}-${local.web_name}"
  vm_db_name  = "${local.company}-${local.platform}-${local.db_name}"
  pub_ssh_key = file("${var.home_path}/.ssh/ya_netology_ed25519.pub")
}