variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = KUBECONFIG
}

variable "deployment_image" {
  description = "Docker image for the Kubernetes deployment"
  type        = string
  default     = "${DOCKER_IMAGE}:${DOCKER_TAG}"
}
