module "policy_sdk_repository_rust" {
  source = "./modules/repository"

  name                   = "policy-sdk-rust"
  description            = "Kubewarden Policy SDK for the Rust programming language"
  extra_topics           = [
    "kubewarden-policy-sdk",
    "rust",
    "rust-language",
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_sdk_repository_swift" {
  source = "./modules/repository"

  name                   = "policy-sdk-swift"
  description            = "Kubewarden Policy SDK for the Swift programming language"
  extra_topics           = [
    "kubewarden-policy-sdk",
    "swift",
  ]
  homepage_url           = "https://kubewarden.github.io/policy-sdk-swift/"
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]
  pages                  = [{
    source_branch = "gh-pages"
    source_path   = "/"
  }]

  providers = {
    github = github.kubewarden
  }
}

module "policy_sdk_repository_go" {
  source = "./modules/repository"

  name                   = "policy-sdk-go"
  description            = "Kubewarden Policy SDK for the Go programming language"
  extra_topics           = [
    "kubewarden-policy-sdk",
    "go",
    "tinygo",
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_sdk_repository_dotnet" {
  source = "./modules/repository"

  name                   = "policy-sdk-dotnet"
  description            = "Kubewarden Policy SDK for the .NET platform"
  extra_topics           = [
    "kubewarden-policy-sdk",
    "dotnet",
    "csharp",
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_sdk_repository_js" {
  source = "./modules/repository"

  name                   = "policy-sdk-js"
  description            = "Experimental Kubewarden SDK for TypeScript and JavaScript"
  extra_topics           = [
    "kubewarden-policy-sdk",
    "javascript",
    "typescript",
  ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}
