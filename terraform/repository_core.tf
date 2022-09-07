module "kubewarden_policy_fetcher_repository" {
  source = "./modules/repository"

  name                   = "policy-fetcher"
  description            = "Crate used by Kubewarden that is able to pull policies from OCI registries and HTTP servers."
  extra_topics           = [
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_kubewarden_controller_repository" {
  source = "./modules/repository"

  name                   = "kubewarden-controller"
  description            = "Manage admission policies in your Kubernetes cluster with ease"
  extra_topics           = [
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_policy_server_repository" {
  source = "./modules/repository"

  name                   = "policy-server"
  description            = "Webhook server that evaluates WebAssembly policies to validate Kubernetes requests"
  extra_topics           = [
    "kubernetes-webhook",
    "policy",
    "rust",
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_kwctl_repository" {
  source = "./modules/repository"

  name                   = "kwctl"
  description            = "Go-to CLI tool for Kubewarden users"
  extra_topics           = [
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}
