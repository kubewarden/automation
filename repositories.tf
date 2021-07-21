resource "github_team_repository" "make_kubewarden_developers_to_all_repos" {
  count = length(data.github_repositories.repos.names)

  team_id    = data.github_team.kubewarden_developers.id
  repository = element(data.github_repositories.repos.names, count.index)
  permission = "push"
}
