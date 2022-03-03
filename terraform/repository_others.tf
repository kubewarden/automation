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

module "kubewarden_github_actions_repository" {
  source = "./modules/repository"

  name                   = "github-actions"
  description            = "GitHub actions used by the Kubewarden project"
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}


module "kubewarden_policy_hub_repository" {
  source = "./modules/repository"

  name                   = "policy-hub"
  description            = "A place where to find and discover policies"
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]
  homepage_url           = "https://hub.kubewarden.io"
  pages                  = [{
    source_branch = "gh-pages"
    source_path   = "/"
    cname         = "hub.kubewarden.io"
  }]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_docs_repository" {
  source = "./modules/repository"

  name                   = "docs"
  description            = "Kubewarden's documentation"
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id,
                             data.github_team.kubewarden_documentation.id ]
  homepage_url           = "https://docs.kubewarden.io"
  pages                  = [{
    source_branch = "gh-pages"
    source_path   = "/"
    cname         = "docs.kubewarden.io"
  }]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_rfc_repository" {
  source = "./modules/repository"

  name                   = "rfc"
  description            = "Kubewarden's RFCs"
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id,
                             data.github_team.kubewarden_documentation.id ]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}
