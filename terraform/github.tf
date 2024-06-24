terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.2.2"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
