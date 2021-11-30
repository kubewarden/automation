module "setup_kubewarden_cluster_action_repository" {
  source = "./modules/repository"

  name                   = "setup-kubewarden-cluster-action"
  description            = "Github action used to setup a K3D cluster and install Kubewarden stack on it"
  extra_topics           = [
    "github-actions",
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_end_to_end_tests_repository" {
  source = "./modules/repository"

  name                   = "kubewarden-end-to-end-tests"
  description            = "Files used to run Kubewarden end-to-end tests"
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}
