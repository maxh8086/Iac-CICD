provider "kubernetes" {
  kubeconfig = file(var.kubeconfig_path)
}

resource "kubernetes_deployment" "apache" {
  metadata {
    name = "apache-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "apache"
      }
    }

    template {
      metadata {
        labels = {
          app = "apache"
        }
      }

      spec {
        container {
          image = "${var.deployment_image}"
          name  = "apache"
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apache" {
  metadata {
    name = "apache-service"
  }

  spec {
    selector = {
      app = "apache"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }

    type = "NodePort"
  }
}
