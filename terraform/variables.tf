variable "DOCKER_IMAGE" {
  description = "Docker image for the Kubernetes deployment"
  type        = string
}

variable "DOCKER_TAG" {
  description = "Docker tag for the Kubernetes deployment"
  type        = string
}

locals {
  kubeconfig_path = "${var.KUBECONFIG}"
  deployment_image = "${var.DOCKER_IMAGE}:${var.DOCKER_TAG}"
}
