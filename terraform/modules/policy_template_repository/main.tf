terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.31.0"
    }
  }
}

locals {
  policy_topics = [
    "hacktoberfest",
    "kubernetes",
    "kubernetes-security",
    "kubewarden-policy-template",
    "policy-as-code",
    "webassembly",
  ]
}

variable "has_downloads" {
  default = false
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

variable "is_template" {
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

variable teams_with_push_rights {
  default = []
}

variable homepage_url {
  default = "https://kubewarden.io"
}

resource "github_repository" "main" {
  name                 = var.name
  topics               = concat( local.policy_topics, var.extra_topics)
  description          = var.description
  has_downloads        = var.has_downloads
  has_issues           = var.has_issues
  has_projects         = var.has_projects
  has_wiki             = var.has_wiki
  is_template          = var.is_template
  homepage_url         = var.homepage_url
  vulnerability_alerts = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      # this is still beta
      status = "disabled"
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
