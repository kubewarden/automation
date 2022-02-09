terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.20.0"
    }
  }
}

locals {
  topics = [
    "hacktoberfest",
    "kubernetes",
    "kubernetes-security",
    "policy-as-code",
    "webassembly",
  ]
}

variable "has_downloads" {
  default = true
}

variable "has_issues" {
  default = true
}

variable "has_projects" {
  default = false
}

variable "has_wiki" {
  default = true
}

variable "name" {
}

variable "description" {
  default = ""
}

variable "extra_topics" {
  default = []
}

variable "homepage_url" {
  default = ""
}

variable template {
  default = []
}

variable pages {
  default = []
}

variable teams_with_push_rights {
  default = []
}

resource "github_repository" "main" {
  name                 = var.name
  topics               = concat( local.topics, var.extra_topics)
  description          = var.description
  has_downloads        = var.has_downloads
  has_issues           = var.has_issues
  has_projects         = var.has_projects
  has_wiki             = var.has_wiki
  vulnerability_alerts = true
  homepage_url         = var.homepage_url

  dynamic "pages" {
    for_each = var.pages
    content {
      cname = lookup(pages.value, "cname", "")
      source {
        branch = pages.value["source_branch"]
        path   = pages.value["source_path"]
      }
    }
  }

  dynamic "template" {
    for_each = var.template
    content {
      owner      = template.value["owner"]
      repository = template.value["repository"]
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_team_repository" "gh_team_push_rights" {
  count      = length(var.teams_with_push_rights)
  team_id    = element(var.teams_with_push_rights, count.index)
  repository = github_repository.main.id
  permission = "push"
}
