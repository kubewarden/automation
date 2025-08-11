terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.45.0"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
