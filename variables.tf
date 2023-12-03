variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = var.KUBECONFIG
}

variable "deployment_image" {
  description = "Docker image for the Kubernetes deployment"
  type        = string
  default     = "${var.DOCKER_IMAGE}:${var.DOCKER_TAG}"
}
