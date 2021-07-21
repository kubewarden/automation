terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.12.2"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
}
