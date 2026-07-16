moved {
  from = module.kubewarden_kubewarden_controller_repository
  to   = module.kubewarden_adm_controller_repository
}

module "kubewarden_adm_controller_repository" {
  source = "./modules/repository"

  name        = "adm-controller"
  description = "Manage admission policies in your Kubernetes cluster with ease"
  extra_topics = [
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}
