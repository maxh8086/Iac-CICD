variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = var.KUBECONFIG
}

variable "docker_image" {
  description = "Docker image for the Kubernetes deployment"
  type        = string
  default     = "maxh8086/apache:latest"
}
