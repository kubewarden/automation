terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.35.0"
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
  default = "https://kubewarden.io"
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

variable "issue_labels" {
  default = {
    # Tango palette
    # Terraform labels are case-sensitive, color hex code should not include the
    # leading '#' character
    "area/dependencies"      = "D3D7CF"

    "kind/bug"               = "EF2929"
    "kind/chore"             = "555753"
    "kind/enhancement"       = "06989A"
    "kind/feature"           = "34E2E2"
    "kind/tech-debt"         = "729FCF"
    "kind/breaking-change"   = "FCE94F"
    "kind/automation"        = "3465A4"
    "kind/question"          = "ad7fa8"

    "release/major"          = "8AE234"
    "release/minor"          = "4E9A06"
    "release/patch"          = "aa6600"
    "release/skip-changelog" = "77cc00"
  }
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

resource "github_app_installation_repository" "app_dco" {
  installation_id    = "29141080"
  repository         = github_repository.main.name
}

resource "github_issue_label" "label" {
  repository = github_repository.main.name
  count      = "${length(var.issue_labels)}"
  name       = "${element(keys(var.issue_labels), count.index)}"
  color      = "${element(values(var.issue_labels), count.index)}"
}
