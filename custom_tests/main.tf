terraform {
  required_version = ">= 1.3.9"
}

resource "random_password" "password" {
  length           = 32
  min_lower        = 5
  min_numeric      = 5
  min_special      = 5
  min_upper        = 5
  special          = true
  override_special = "!#%&*()-_=+[]{}<>:?"
}

resource "kubernetes_secret" "example" {
  metadata {
    name      = "basic-auth"
    namespace = var.namespace
  }

  data = {
    username = var.username
    password = resource.random_password.password.result
  }

  type = "generic"
}
