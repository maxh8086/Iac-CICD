terraform {
  backend "local" {
    // Add backend configuration here if needed
  }
}

module "kubernetes_deployment" {
  source = "git::https://github.com/maxh8086/Iac-CICD.git"

  // You can provide any other required variables for your module here
}

