terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.27.1"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
