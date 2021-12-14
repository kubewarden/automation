data "github_repositories" "repos" {
  query = "org:kubewarden"
}

data "github_team" "kubewarden_developers" {
  slug     = "kubewarden-developers"
  provider = github.kubewarden
}

data "github_team" "kubewarden_documentation" {
  slug     = "kubewarden-documentation"
  provider = github.kubewarden
}
