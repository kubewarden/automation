data "github_repositories" "repos" {
  query = "org:kubewarden"
}

data "github_organization" "kubewarden" {
  name = "kubewarden"
}

data "github_team" "kubewarden_developers" {
  slug = "kubewarden-developers"
}
