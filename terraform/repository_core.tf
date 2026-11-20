locals {
  core_issue_labels = {
    "area/release" = "F57900"
  }
}

module "kubewarden_adm_controller_repository" {
  source = "./modules/repository"

  name         = "adm-controller"
  description  = "Manage admission policies in your Kubernetes cluster with ease"
  homepage_url = "https://www.kubewarden.io/component/adm-controller/"

  allow_auto_merge                = true
  secret_scanning_push_protection = "enabled"

  extra_topics = [
    "admission-controller",
    "cel-lang",
    "gatekeeper",
    "open-policy-agent",
    "rego",
    "wasm",
    "webassembly",
  ]
  extra_issue_labels     = local.core_issue_labels
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_gateway_protector_repository" {
  source = "./modules/repository"

  name         = "gateway-protector"
  description  = "Web application firewall (WAF) for the Kubernetes Gateway API, built on Coraza and the OWASP Core Rule Set."
  homepage_url = "https://www.kubewarden.io/component/gateway-protector/"

  has_wiki     = false
  has_projects = true

  allow_auto_merge                = true
  secret_scanning_push_protection = "enabled"

  topics = [
    "agentgateway",
    "coraza",
    "gateway-api",
    "kubernetes",
    "kubewarden",
    "owasp-crs",
    "security",
    "waf",
  ]
  extra_issue_labels = local.core_issue_labels

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_runtime_enforcer_repository" {
  source = "./modules/repository"

  name         = "runtime-enforcer"
  description  = "A runtime enforcement solution for your Kubernetes cluster"
  homepage_url = "https://www.kubewarden.io/component/runtime-enforcer/"

  has_projects = true

  allow_auto_merge                = true
  allow_squash_merge              = false
  allow_rebase_merge              = false
  delete_branch_on_merge          = true
  secret_scanning_push_protection = "enabled"

  topics = [
    "ebpf",
    "kubernetes",
    "kubernetes-security",
    "policy-as-code",
    "runtime-security",
  ]
  extra_issue_labels = local.core_issue_labels

  providers = {
    github = github.kubewarden
  }
}

module "kubewarden_network_enforcer_repository" {
  source = "./modules/repository"

  name         = "network-enforcer"
  description  = "Generate and enforce Kubernetes NetworkPolicies from observed workload traffic"
  homepage_url = "https://www.kubewarden.io/component/network-enforcer/"

  has_projects = true

  allow_auto_merge                = true
  allow_squash_merge              = false
  allow_rebase_merge              = false
  delete_branch_on_merge          = true
  secret_scanning_push_protection = "enabled"

  topics = [
    "calico",
    "calico-cni",
    "cilium",
    "istio-ambient",
    "kubernetes",
    "kubernetes-network",
    "kubernetes-networking",
    "network-monitoring",
    "network-security",
    "networking",
    "policy-as-code",
  ]
  extra_issue_labels = local.core_issue_labels

  providers = {
    github = github.kubewarden
  }
}
