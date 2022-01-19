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
