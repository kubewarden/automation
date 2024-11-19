module "policy_template_repository_gatekeeper" {
  source = "./modules/policy_template_repository"

  name        = "gatekeeper-policy-template"
  description = "A template repository to quickly port a Gatekeeper policy to Kubewarden"
  extra_topics = [
    "rego",
    "gatekeeper",
    "gatekeeper-v2",
    "gatekeeper-policies",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_template_repository_go" {
  source = "./modules/policy_template_repository"

  name        = "go-policy-template"
  description = "A template repository to quickly scaffold a Kubewarden policy written with Go language"
  extra_topics = [
    "go",
    "golang",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_template_repository_go_wasi" {
  source = "./modules/policy_template_repository"

  name        = "go-wasi-policy-template"
  description = "Template of a plain WASI policy written using Go "
  extra_topics = [
    "go",
    "golang",
    "wasi",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_template_repository_opa" {
  source = "./modules/policy_template_repository"

  name        = "opa-policy-template"
  description = "A template repository to quickly port a Open Policy Agent policy to Kubewarden"
  extra_topics = [
    "opa",
    "open-policy-agent",
    "openpolicyagent",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_template_repository_rust" {
  source = "./modules/policy_template_repository"

  name        = "rust-policy-template"
  description = "A Kubewarden rust policy template to be used with cargo-generate"
  is_template = false
  extra_topics = [
    "rust",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_template_repository_swift" {
  source = "./modules/policy_template_repository"

  name        = "swift-policy-template"
  description = "A template repository to quickly scaffold a Kubewarden policy written with Swift language"
  extra_topics = [
    "swift",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_template_repository_dotnet" {
  source = "./modules/policy_template_repository"

  name        = "dotnet-policy-template"
  description = "A template repository to quickly scaffold a Kubewarden policy written with C#"
  extra_topics = [
    "dotnet",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}
