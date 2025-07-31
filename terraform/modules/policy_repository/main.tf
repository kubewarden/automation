terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.37.0"
    }
  }
}

locals {
  policy_topics = [
    "hacktoberfest",
    "kubernetes",
    "kubernetes-security",
    "kubewarden-policy",
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

variable "template" {
  default = []
}

variable "teams_with_push_rights" {
  default = []
}

variable "homepage_url" {
  default = "https://kubewarden.io"
}

variable "issue_labels" {
  default = {
    # Tango palette
    # Terraform labels are case-sensitive, color hex code should not include the
    # leading '#' character
    "area/dependencies" = "D3D7CF"
    "area/release"      = "F57900"

    "kind/bug"             = "EF2929"
    "kind/chore"           = "555753"
    "kind/enhancement"     = "06989A"
    "kind/feature"         = "34E2E2"
    "kind/tech-debt"       = "729FCF"
    "kind/breaking-change" = "FCE94F"
    "kind/automation"      = "3465A4"
    "kind/question"        = "ad7fa8"
    "kind/to-be-refined"   = "B14FCF"

    "release/major"          = "8AE234"
    "release/minor"          = "4E9A06"
    "release/patch"          = "aa6600"
    "release/skip-changelog" = "77cc00"
    "TRIGGER-RELEASE"        = "8AE234"

    "good first issue" = "7057ff" # CNCF landscape expect this exact label string
  }
}

resource "github_repository" "main" {
  name                 = var.name
  topics               = concat(local.policy_topics, var.extra_topics)
  description          = var.description
  has_downloads        = var.has_downloads
  has_issues           = var.has_issues
  has_projects         = var.has_projects
  has_wiki             = var.has_wiki
  homepage_url         = var.homepage_url
  vulnerability_alerts = true
  #web_commit_signoff_required = true

  dynamic "template" {
    for_each = var.template
    content {
      owner      = template.value["owner"]
      repository = template.value["repository"]
    }
  }

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
  for_each   = toset(var.teams_with_push_rights)
  team_id    = each.value
  repository = github_repository.main.id
  permission = "push"
}

resource "github_issue_label" "label" {
  for_each   = var.issue_labels
  repository = github_repository.main.name
  name       = each.key
  color      = each.value
}
