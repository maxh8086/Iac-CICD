variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
}

variable "deployment_image" {
  description = "Docker image for the Kubernetes deployment"
}

locals {
  kubeconfig = var.kubeconfig_path
  deployment_image = "${var.DOCKER_IMAGE}:${var.DOCKER_TAG}"
}
