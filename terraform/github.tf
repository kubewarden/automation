terraform {
  required_providers {
    github = {
      source = "integrations/github"
      # WARNING: do not update to a version > 5.37.0 until https://github.com/integrations/terraform-provider-github/issues/2077 is resolved
      version = "5.45.0"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
