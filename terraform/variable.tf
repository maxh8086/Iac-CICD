# variables.tf

variable "kubeconfig_path" {
  description = "Path to the Kubernetes configuration file (kubeconfig)"
  type        = string
  default     = "/home/jenkins/.kube/config"
}
