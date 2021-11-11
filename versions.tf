terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.3"
    }
  }
  required_version = ">= 0.15"
}
