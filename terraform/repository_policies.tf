module "policy_repository_rego_policies_library" {
  source = "./modules/policy_repository"

  name                   = "rego-policies-library"
  description            = "A collection of Rego policies that can be used to enforce best practices in Kubernetes clusters"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  extra_topics = [
    "rego",
    "compliance",
    "gatekeeper",
  ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_policies" {
  source = "./modules/policy_repository"

  name                   = "policies"
  description            = "Kubewarden policies"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  extra_issue_labels = {
    "TRIGGER-RELEASE"                                = "8AE234"
    "pod-privileged-policy"                          = "EDEDED"
    "user-group-psp-policy"                          = "EDEDED"
    "deprecated-api-versions-policy"                 = "EDEDED"
    "labels-policy"                                  = "EDEDED"
    "trusted-repos-policy"                           = "EDEDED"
    "allowed-proc-mount-types-psp-policy"            = "EDEDED"
    "allow-privilege-escalation-psp-policy"          = "EDEDED"
    "capabilities-psp-policy"                        = "EDEDED"
    "apparmor-psp-policy"                            = "EDEDED"
    "env-variable-secrets-scanner-policy"            = "EDEDED"
    "seccomp-psp-policy"                             = "EDEDED"
    "pod-runtime-class-policy"                       = "EDEDED"
    "allowed-fsgroups-psp-policy"                    = "EDEDED"
    "readonly-root-filesystem-psp-policy"            = "EDEDED"
    "image-cve-policy"                               = "EDEDED"
    "volumeMounts-policy"                            = "EDEDED"
    "echo"                                           = "EDEDED"
    "environment-variable-policy"                    = "EDEDED"
    "persistentvolumeclaim-storageclass-policy"      = "EDEDED"
    "selinux-psp-policy"                             = "EDEDED"
    "host-namespaces-psp-policy"                     = "EDEDED"
    "flexvolume-drivers-psp-policy"                  = "EDEDED"
    "psa-label-enforcer-policy"                      = "EDEDED"
    "probes-policy"                                  = "EDEDED"
    "unique-service-selector-policy"                 = "EDEDED"
    "pod-ndots-policy"                               = "EDEDED"
    "annotations-policy"                             = "EDEDED"
    "priority-class-policy"                          = "EDEDED"
    "raw-validation-policy"                          = "EDEDED"
    "sleeping-policy"                                = "EDEDED"
    "do-not-expose-admission-controller-webhook-svc" = "EDEDED"
    "share-pid-namespace-policy"                     = "EDEDED"
    "verify-image-signatures"                        = "EDEDED"
    "context-aware-demo"                             = "EDEDED"
    "ingress-policy"                                 = "EDEDED"
    "safe-annotations-policy"                        = "EDEDED"
    "hostpaths-psp-policy"                           = "EDEDED"
    "safe-labels-policy"                             = "EDEDED"
    "volumes-psp-policy"                             = "EDEDED"
    "sysctl-psp-policy"                              = "EDEDED"
    "namespace-label-propagator-policy"              = "EDEDED"
    "go-wasi-context-aware-test-policy"              = "EDEDED"
    "container-resources-policy"                     = "EDEDED"
    "raw-mutation-policy"                            = "EDEDED"
    "rancher-project-quotas-namespace-validator"     = "EDEDED"
    "cel-policy"                                     = "EDEDED"
    "raw-mutation-wasi-policy"                       = "EDEDED"
    "raw-validation-wasi-policy"                     = "EDEDED"
    "kyverno-dsl-policy"                             = "EDEDED"
    "disallow-service-nodeport-policy"               = "EDEDED"
    "disallow-service-loadbalancer-policy"           = "EDEDED"
    "raw-validation-opa-policy"                      = "EDEDED"
    "unique-ingress-policy"                          = "EDEDED"
  }

  providers = {
    github = github.kubewarden
  }
}
