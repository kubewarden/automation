#!/usr/bin/env bash
set -eEuo pipefail

# ==================================================================================================
# Logging & Functions & Traps

yq() { command yq -e "$@"; }
jq() { command jq -e "$@"; }

exec 3>&1     # keep logs on stdout after redirection
DATADIR="$PWD/data"
REPORT="output/script.log"
OUTPUT="output/script-full.log"

log  () { printf -- "$(date +%R) \e[${1}m${*:2}\e[0m\n" | tee -a "$OUTPUT" "$REPORT" >&3; }
step () { log 32 "${*}" $(basename "${BASH_SOURCE[1]/${BASH_SOURCE}}" | sed 's/.\+/[&]/'); } # print test module
info () { log 0  "  ${*}"; }
warn () { log 33 "  ${*}"; }
error() { log 31 "  ${*}"; }

trap_exit() {
    status=$?
    if [ $status -ne 0 ]; then
        tail -20 "$OUTPUT" | sed -r -e 's:\x1b\[[0-9;]*[mK]::g' -e 's/^/> /' >&3
    fi
    [ -f "$REPORT" ] && sed -ri 's:\x1b\[[0-9;]*[mK]::g' "$REPORT" # remove colors
    exit $status
}

trap 'echo "Error on ${BASH_SOURCE}:${LINENO} $(sed -n "${LINENO} s/^\s*//p" ${BASH_SOURCE})"' ERR
trap 'trap_exit' EXIT

exec &>> $OUTPUT
echo -n | tee $REPORT > $OUTPUT

# ==================================================================================================
# Helper functions

# Get crds for flux (helmreleases, buckets, helmcharts, helmrepositories, kustomizations, ...)
# kubectl apply -f https://github.com/fluxcd/flux2/releases/latest/download/install.yaml

do_readme() {
    yq '"# " + .spec.name' "$INDIR/policy.yaml"
    echo

    yq '.spec.description' "$INDIR/policy.yaml"
    echo
    yq '.spec.how_to_solve' "$INDIR/policy.yaml"
    echo

    echo "# Settings"
    echo '```yaml'
    yq '{"settings":{"parameters": .spec.parameters}}' "$INDIR/policy.yaml" | sed 's/^/  /'
    echo '```'
    echo

    echo "# Resources"
    echo "Policy applies to resources kinds:"
    yq '.spec.targets.kinds | map("`" + . + "`") | join(", ")' "$INDIR/policy.yaml"
}

do_metadata() {
    KINDS="${1:-}" yq '{"rules":
        # Define the target kinds from the input spec
        .spec.targets.kinds // (strenv(KINDS) | split(",")) as $targetKinds |

        # Load the kinds mapping from the separate YAML file
        load("data/kinds-mapping.yaml").kinds_mapping as $kindMap |

        # Create an array of matched kinds
        [
            $targetKinds[] |
            select($kindMap[.]) |
            {"name": ., "details": $kindMap[.]}
        ] |

        # Group by API group
        group_by(.details.apiGroup) |

        # Transform each group
        map({
            "apiGroups": [.[0].details.apiGroup] | . style="flow",
            "apiVersions": [.[0].details.apiVersion] | . style="flow",
            "resources": [map(.details.resource)[]] | . style="flow",
            "operations": ["CREATE", "UPDATE"] | . style="flow"
        })}
    ' "$INDIR/policy.yaml"

    yq '{
        "mutating": false,
        "executionMode": "gatekeeper",
        "backgroundAudit": true
    }' "$INDIR/policy.yaml"

    # select(.spec.tags | any) | "io.artifacthub.keywords": .spec.tags | join(", "),
    # "io.artifacthub.keywords": .spec.tags | select(length > 0) | join(", "),
    KINDS="${1:-}" yq '{"annotations": (
        {
        "io.artifacthub.displayName": .spec.name,
        "io.artifacthub.keywords": .spec.tags // [] | join(", "),
        "io.artifacthub.resources": .spec.targets.kinds // (strenv(KINDS) | split(",")) | join(", "),
        "io.kubewarden.policy.title": .spec.id | sub("weave.(policies|templates)."; ""),
        "io.kubewarden.policy.description": .spec.description, # TODO: fix newlines
        "io.kubewarden.policy.author": "Kubewarden developers <cncf-kubewarden-maintainers@lists.cncf.io>",
        "io.kubewarden.policy.ociUrl": "ghcr.io/kubewarden/policies/" + .spec.id | sub("weave.(policies|templates)."; ""),
        "io.kubewarden.policy.url": "https://github.com/kubewarden/rego-policies",
        "io.kubewarden.policy.source": "https://github.com/kubewarden/rego-policies",
        "io.kubewarden.policy.license": "Apache-2.0",
        "io.kubewarden.policy.category": .spec.category | sub("weave.categories."; ""),
        "io.kubewarden.policy.severity": .spec.severity
        }
        # + ({key "io.artifacthub.keywords": .spec.tags | select(length != 0) | join(", ")} | from_entries)
        + (.spec.standards // [] | map({"key": "io.kubewarden.policy.standards." + (.id | sub("weave.standards."; "")), "value": (.controls | map(sub("weave.controls."; "")) | join(", "))}) | from_entries)
    )}' "$INDIR/policy.yaml"

}

# ==================================================================================================

# Use parameter as policy name or target all policies/examples
POLICIES="${1:-$(grep -hv ^# $DATADIR/policies.txt $DATADIR/examples.txt)}"
# Grep rego files for resources if not defined in policy.yaml
RESOURCES='StatefulSet|DaemonSet|Deployment|Job|Pod|CronJob|Role|ServiceAccount|Service|NetworkPolicy|ClusterBinding|ReplicaSet|ClusterRoleBinding|PersistentVolume|Ingress|Gateway|Namespace|Node|LimitRange|ResourceQuota|VolumeSnapshot|Bucket|GitRepository|HelmChart|HelmRelease|HelmRepository|Kustomization|OCIRepository|ReplicationController|HorizontalAutoscaler'

for pol in $POLICIES; do
    # Find policy directory by name
    INDIR="$(find input/ -type d -name $pol)"
    # Default output directory
    OUTDIR="output/policies/$pol"
    # Staging dir for policies without tests
    ls "$INDIR/tests/"*.rego &>/dev/null || OUTDIR="output/staging/$pol"

    step "$pol [${INDIR%\/$pol}]"
    mkdir -p "$OUTDIR"
    cp "$DATADIR/Makefile" "$OUTDIR/"
    cp "$INDIR/policy.rego" "$INDIR/policy.yaml" "$OUTDIR/"
    sed -Ei 's/^(\s*)package weave.advisor.*/\1package policy/' "$OUTDIR/policy.rego"

    # Make policy tests
    if test -d "$INDIR/tests/"; then
        cp -r "$INDIR/tests/" "$OUTDIR/"
        sed -Ei 's/^(\s*)package weave.advisor.*/\1package policy/' "$OUTDIR/tests/"*
        ls "$OUTDIR/tests/"*.rego &>/dev/null && sed -Ei 's/^(import data).weave.*(.violation)/\1.policy\2/; s/^(import data).weave.*/\1.policy/' "$OUTDIR/tests/"*.rego
    fi

    # Make policy rules
    KINDS=""
    if ! yq -e '.spec.targets.kinds' "$OUTDIR/policy.yaml" &>/dev/null; then
        # info "Generate rules"
        grep -E 'controller_input.kind|input.review.object.kind|contains_kind' "$OUTDIR/policy.rego" || { error "Policy without rules"; continue; }
        KINDS=$(grep -E 'controller_input.kind|input.review.object.kind|contains_kind' "$OUTDIR/policy.rego" |\
            grep -oE "$RESOURCES" | sort -u | paste -sd',')
    fi

    # info "Create readme"
    do_readme | tee "$OUTDIR/README.md"

    # info "Create metadata"
    do_metadata "$KINDS" | tee "$OUTDIR/metadata.yml"
    sed -i '/io.kubewarden.policy.standards/ s/i/# i/' "$OUTDIR/metadata.yml" # Comment out standards
    yq -i 'del(.annotations."io.artifacthub.keywords" | select(. == ""))' "$OUTDIR/metadata.yml" # Remove empty keywords
    if grep -w "$pol" "$INDIR/../../goodpractices/kubernetes/rbac/secrets/kustomization.yaml" > /dev/null; then
        yq -i '.annotations."io.kubewarden.policy.category" = "Best practices RBAC"' "$OUTDIR/metadata.yml"
    fi

    # info "Test and build"
    ls "$OUTDIR/tests/"*.rego  &>/dev/null && make -C "$OUTDIR" test
    ls "$OUTDIR/tests/"*.y?ml  &>/dev/null && { ./test_policies --policy-path "$OUTDIR" || error "Yaml tests failed"; }
    make -C "$OUTDIR" artifacthub-pkg.yml VERSION=0.0.1
    make -C "$OUTDIR" policy.wasm annotated-policy.wasm

done

step "Done."

# ==================================================================================================
# KubernetesProhibitKind - rules target Pod[s!], should target everything