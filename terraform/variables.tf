locals {
  kubeconfig = var.kubeconfig_path
  deployment_image = "${var.DOCKER_IMAGE}:${var.DOCKER_TAG}"
}
