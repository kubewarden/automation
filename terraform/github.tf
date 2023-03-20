terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.18.3"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
