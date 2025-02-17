
module "kubewarden_end_to_end_tests_repository" {
  source = "./modules/repository"

  name                   = "kubewarden-end-to-end-tests"
  description            = "Files used to run Kubewarden end-to-end tests"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_github_actions_repository" {
  source = "./modules/repository"

  name                   = "github-actions"
  description            = "GitHub actions used by the Kubewarden project"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}


module "kubewarden_policy_hub_repository" {
  source = "./modules/repository"

  name                   = "policy-hub"
  description            = "A place where to find and discover policies"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://hub.kubewarden.io"
  pages = [{
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

  name        = "docs"
  description = "Kubewarden's documentation"
  teams_with_push_rights = [
    data.github_team.kubewarden_developers.id,
  data.github_team.kubewarden_documentation.id]
  homepage_url = "https://docs.kubewarden.io"
  pages = [{
    source_branch = "gh-pages"
    source_path   = "/"
    cname         = "docs.kubewarden.io"
  }]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_io_repository" {
  source = "./modules/repository"

  name        = "kubewarden.io"
  description = "Kubewarden website"
  teams_with_push_rights = [
    data.github_team.kubewarden_developers.id,
  data.github_team.kubewarden_documentation.id]
  homepage_url = "https://kubewarden.io"
  pages = [{
    source_branch = "gh-pages"
    source_path   = "/"
    cname         = "www.kubewarden.io"
  }]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_rfc_repository" {
  source = "./modules/repository"

  name        = "rfc"
  description = "Kubewarden's RFCs"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id,
  data.github_team.kubewarden_documentation.id]
  homepage_url = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_strfmt_repository" {
  source = "./modules/repository"

  name                   = "strfmt"
  description            = "A stripped down version of go-openapi/strfrm that works with TinyGo"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_k8s_objects_repository" {
  source = "./modules/repository"

  name                   = "k8s-objects"
  description            = "Experimental: Kubernetes Go types that can be used with TinyGo"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_k8s_objects_generator_repository" {
  source = "./modules/repository"

  name                   = "k8s-objects-generator"
  description            = "CLI tool that generates Kubernetes Go types that can be used with TinyGo starting from the official OpenAPI spec"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_rancher_kubectl_builder_repository" {
  source = "./modules/repository"

  name                   = "rancher-kubectl-builder"
  description            = "Workflow to rebuild and sign rancher/kubectl image"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_utils_repository" {
  source = "./modules/repository"

  name                   = "utils"
  description            = "Utils scripts used by the Kubewarden team and users."
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_load_testing_repository" {
  source = "./modules/repository"

  name                   = "load-testing"
  description            = "HTTP load to stress policy-server"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_fleet_example_repository" {
  source = "./modules/repository"

  name                   = "fleet-example"
  description            = "Example of Rancher Fleet bundle for Kubewarden"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  homepage_url           = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_community_repository" {
  source = "./modules/repository"

  name        = "community"
  description = "Kubewarden's community repository"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id,
  data.github_team.kubewarden_documentation.id]
  homepage_url = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_policy_charts" {
  source = "./modules/repository"

  name        = "policy-charts"
  description = "Kubewarden policy Helm charts for Rancher UI"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id,
  data.github_team.kubewarden_documentation.id]
  homepage_url = "https://github.com/kubewarden/"

  providers = {
    github = github.kubewarden
  }
}
