module "policy_repository_ingress_policy" {
  source = "./modules/policy_repository"

  name        = "ingress-policy"
  description = "Policy to enforce requirements on Kubernetes Ingress resources."
  extra_topics = [
    "ingress",
    "ingresses-resources",
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_pod_privileged_policy" {
  source = "./modules/policy_repository"

  name                   = "pod-privileged-policy"
  description            = "A Kubewarden Policy that limits the ability to create privileged containers"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_pod_runtime_class_policy" {
  source = "./modules/policy_repository"

  name                   = "pod-runtime-class-policy"
  description            = "A Kubewarden Policy that controls the usage of Pod runtimeClass"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_disallow_service_loadbalancer_policy" {
  source = "./modules/policy_repository"

  name        = "disallow-service-loadbalancer-policy"
  description = "A policy that prevents the creation of Service resources with type LoadBalancer"
  extra_topics = [
    "open-policy-agent",
    "gatekeeper"
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_disallow_service_nodeport_policy" {
  source = "./modules/policy_repository"

  name        = "disallow-service-nodeport-policy"
  description = "A policy that prevents the creation of Service resources with type NodePort"
  extra_topics = [
    "open-policy-agent",
    "gatekeeper"
  ]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_user_group_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "user-group-psp-policy"
  description            = "This Kubewarden Policy is a replacement for the Kubernetes Pod Security Policy that controls containers user and groups"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_allow_privilege_escalation_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "allow-privilege-escalation-psp-policy"
  description            = "A Kubewarden Pod Security Policy that controls usage of allowPrivilegeEscalation"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_allowed_fsgroups_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "allowed-fsgroups-psp-policy"
  description            = "Replacement for the Kubernetes Pod Security Policy that controls the usage of fsGroup in the pod security context"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_allowed_proc_mount_types_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "allowed-proc-mount-types-psp-policy"
  description            = "Replacement for the Kubernetes Pod Security Policy that controls the usage of /proc mount types"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_apparmor_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "apparmor-psp-policy"
  description            = "A Kubewarden Pod Security Policy that controls usage of AppArmor profiles"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_capabilities_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "capabilities-psp-policy"
  description            = "A Pod Security Policy that controls Container Capabilities"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_flexvolume_drivers_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "flexvolume-drivers-psp-policy"
  description            = "Replacement for the Kubernetes Pod Security Policy that controls the allowed `flexVolume` drivers"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_host_namespaces_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "host-namespaces-psp-policy"
  description            = "Replacement for the Kubernetes Pod Security Policy that controls the usage of host namespaces"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_hostpaths_psp_policy" {
  source = "./modules/policy_repository"

  name         = "hostpaths-psp-policy"
  description  = "Replacement for the Kubernetes Pod Security Policy that controls the usage of hostpaths"
  extra_topics = ["pod-security-policy"]
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_selinux_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "selinux-psp-policy"
  description            = "Replacement for the Kubernetes Pod Security Policy that controls the usage of SELinux"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_sysctl_psp_policy" {
  source = "./modules/policy_repository"

  name         = "sysctl-psp-policy"
  description  = "A Kubewarden policy that controls usage of sysctls"
  extra_topics = ["pod-security-policy"]
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_volumes_psp_policy" {
  source = "./modules/policy_repository"

  name         = "volumes-psp-policy"
  description  = "Replacement for the Kubernetes Pod Security Policy that controls the usage of volumes"
  extra_topics = ["pod-security-policy"]
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_safe_annotations_policy" {
  source = "./modules/policy_repository"

  name         = "safe-annotations-policy"
  description  = "Kubewarden policy that validates Kubernetes' resource annotations"
  extra_topics = ["kubernetes-compliance"]
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_safe_labels_policy" {
  source = "./modules/policy_repository"

  name         = "safe-labels-policy"
  description  = "Kubewarden policy that validates Kubernetes' resource labels"
  extra_topics = ["kubernetes-compliance"]
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_trusted_repos_policy" {
  source = "./modules/policy_repository"

  name                   = "trusted-repos-policy"
  description            = "A Kubewarden policy that restricts what registries, tags and images can pods on your cluster refer to"
  extra_topics           = ["kubernetes-compliance"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_readonly_root_filesystem_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "readonly-root-filesystem-psp-policy"
  description            = "A Kubewarden policy that enforces root filesystem to be readonly"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_seccomp_psp_policy" {
  source = "./modules/policy_repository"

  name                   = "seccomp-psp-policy"
  description            = "A Kubewarden Pod Security Policy that controls usage of Seccomp profiles"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_verify_image_signatures_policy" {
  source = "./modules/policy_repository"

  name                   = "verify-image-signatures"
  description            = "A Kubewarden Policy that verifies all the signatures of the container images referenced by a Pod"
  extra_topics           = ["pod-security-policy"]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_echo_policy" {
  source = "./modules/policy_repository"

  name                   = "echo"
  description            = "A Kubewarden Policy that echoes Kubernetes' AdmissionReview objects"
  extra_topics           = []
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_volumeMounts_policy" {
  source = "./modules/policy_repository"

  name                   = "volumeMounts-policy"
  description            = "A Kubewarden Policy that controls the usage of `volumeMounts`"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_env_variable_secrets_scanner_policy" {
  source = "./modules/policy_repository"

  name                   = "env-variable-secrets-scanner-policy"
  description            = "A Kubewarden Policy that detects secrets (ssh private keys, API tokens, etc) leaked via environment variables"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_environment_variable_policy" {
  source = "./modules/policy_repository"

  name                   = "environment-variable-policy"
  description            = "A Kubewarden Policy that controls the usage of environment variables"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_deprecated_api_versions_policy" {
  source = "./modules/policy_repository"

  name                   = "deprecated-api-versions-policy"
  description            = "A Kubewarden Policy that detects usage of deprecated and dropped Kubernetes resources"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_sleeping_policy" {
  source = "./modules/policy_repository"

  name                   = "sleeping-policy"
  description            = "A test policy that simulates long running policy evaluations"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_context_aware_demo_policy" {
  source = "./modules/policy_repository"

  name                   = "context-aware-demo"
  description            = "A demo policy showing how to access Kubernetes resources at policy evaluation time"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_rancher_project_quotas_namespace_validator" {
  source = "./modules/policy_repository"

  name        = "rancher-project-quotas-namespace-validator"
  description = "Prevent the creation of Namespace under a Rancher Project that doesn't have any resource quota left"
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_psa_label_enforcer" {
  source = "./modules/policy_repository"

  name                   = "psa-label-enforcer-policy"
  description            = "Kubewarden policy that ensures that namespaces have the required PSA labels"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_namespace_label_propagator_policy" {
  source = "./modules/policy_repository"

  name        = "namespace-label-propagator-policy"
  description = "Kubewarden policy designed to automatically propagate labels defined in a Kubernetes namespace to the associated resources within that namespace"
  template = [{
    owner      = "kubewarden"
    repository = "go-policy-template"
  }]
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_raw_validation_policy" {
  source = "./modules/policy_repository"

  name                   = "raw-validation-policy"
  description            = "Demo policy showing how to write a raw validating policy"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_raw_mutation_policy" {
  source = "./modules/policy_repository"

  name                   = "raw-mutation-policy"
  description            = "Demo policy showing how to write a raw mutating policy"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_raw_validation_wasi_policy" {
  source = "./modules/policy_repository"

  name                   = "raw-validation-wasi-policy"
  description            = "Demo policy showing how to write a raw WASI validating policy"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_raw_mutation_wasi_policy" {
  source = "./modules/policy_repository"

  name                   = "raw-mutation-wasi-policy"
  description            = "Demo policy showing how to write a raw WASI mutation policy"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_raw_validation_opa_policy" {
  source = "./modules/policy_repository"

  name                   = "raw-validation-opa-policy"
  description            = "Demo policy showing how to write a raw OPA validating policy"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_unique_ingress_policy" {
  source = "./modules/policy_repository"

  name                   = "unique-ingress-policy"
  description            = "Prevent the creation of Ingress resources with duplicated hosts"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_container_resources_policy" {
  source = "./modules/policy_repository"

  name                   = "container-resources-policy"
  description            = "Policy is designed to enforce constraints on the resource requirements of Kubernetes containers"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_share_pid_namespace_policy" {
  source = "./modules/policy_repository"

  name                   = "share-pid-namespace-policy"
  description            = "Policy validates pods sharing processes PID namespace"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_go_wasi_context_aware_test_policy" {
  source = "./modules/policy_repository"

  name                   = "go-wasi-context-aware-test-policy"
  description            = "A test context-aware policy written using Go Wasi"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_unique_service_selector" {
  source = "./modules/policy_repository"

  name                   = "unique-service-selector-policy"
  description            = "Policy validates that there are no services with the same set of selectors"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_persistentvolumeclaim-storageclass" {
  source = "./modules/policy_repository"

  name                   = "persistentvolumeclaim-storageclass-policy"
  description            = "Policy that validates and adjusts the usage of StorageClasses in PersistentVolumeClaims"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_pod_ndots" {
  source = "./modules/policy_repository"

  name                   = "pod-ndots-policy"
  description            = "Policy that enforces the usage of ndots in the pod's DNS configuration"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_image_cve_policy" {
  source = "./modules/policy_repository"

  name                   = "image-cve-policy"
  description            = "Policy that validates workloads based on the vulnerability of the images they make use of"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  extra_topics = [
    "vulnerability-scanner",
    "cve",
    "sbom",
  ]

  providers = {
    github = github.kubewarden
  }
}

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

module "policy_repository_do_not_expose_admission_controller_webhook_services_policy" {
  source = "./modules/policy_repository"

  name                   = "do-not-expose-admission-controller-webhook-services-policy"
  description            = "A policy that detects webhook services used by admission controller that are accidentally exposed outside of the cluster"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  extra_topics = [
    "admissioncontroller",
    "compliance",
  ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_cel_policy" {
  source = "./modules/policy_repository"

  name                   = "cel-policy"
  description            = "A policy that can run CEL expressions"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  extra_topics = [
    "cel",
    "validating-admission-policy",
    "common-expression-language"
  ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_kyverno_dsl_policy" {
  source = "./modules/policy_repository"

  name                   = "kyverno-dsl-policy"
  description            = "[Experimental] Reuse Kyverno policies with Kubewarden"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]
  extra_topics = [
    "kyverno",
    "kyverno-policies"
  ]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_priority_class_policy" {
  source = "./modules/policy_repository"

  name                   = "priority-class-policy"
  description            = "Validates Pod's priority class"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_workload_annotations_policy" {
  source = "./modules/policy_repository"

  name                   = "annotations-policy"
  description            = "Validates annotations"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_repository_workload_labels_policy" {
  source = "./modules/policy_repository"

  name                   = "labels-policy"
  description            = "Validates labels"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}

module "policy_policies" {
  source = "./modules/policy_repository"

  name                   = "policies"
  description            = "Kubewarden policies"
  teams_with_push_rights = [data.github_team.kubewarden_developers.id]

  providers = {
    github = github.kubewarden
  }
}
