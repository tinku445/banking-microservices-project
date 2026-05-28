terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "user_service" {
  metadata {
    name = "terraform-user-service"
    labels = {
      app = "user-service"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "user-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-service"
        }
      }

      spec {
        container {
          image = "banking-user-service:v1"
          name  = "user-service"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user_service" {
  metadata {
    name = "terraform-user-service"
  }

  spec {
    selector = {
      app = "user-service"
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "NodePort"
  }
}