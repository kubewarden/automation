terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.9.1"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
