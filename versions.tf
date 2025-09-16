terraform {
  required_version = "~> 1.10"
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.52.0"
    }
  }
}
