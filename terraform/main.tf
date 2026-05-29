terraform {
  required_providers {

    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.1.0"
    }
  }
}

provider "docker" {}

provider "kubernetes" {
  config_path = "C:/Users/acer/.kube/config"
}

resource "docker_image" "banking_user_image" {
  name = "banking-user-service:v1"
}

resource "docker_container" "banking_user_container" {
  name  = "banking-user-container"
  image = docker_image.banking_user_image.image_id

  ports {
    internal = 5000
    external = 5001
  }
}
