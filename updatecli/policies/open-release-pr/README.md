## DESCRIPTION

This policy opens GitHub PRs on Kubewarden policy repos, preparing them for a release.

It does this by bumping all the needed metadata information, including specific
language-related info when applicable (e.g: `Cargo.toml`).

The changes are committed by default into a branch named
`updatecli_main_release_pr` (see `values.yaml`).

## Settings

Default values are specified in the `values.yaml` file.

## DEVELOP

To test the updatecli `open-release-pr.yml` manifest locally,
you need to copy the updatecli folder into the policy that you are testing with,
or add the needed files in the root of this repository.

This is because the updatecli script is run via the reusable-release-pr workflow.

```console
export UPDATECLI_GITHUB_TOKEN=<your token>

UPDATECLI_GIT_AUTHOR="Kubewarden bot" \
UPDATECLI_GIT_EMAIL="cncf-kubewarden-maintainers@lists.cncf.io" \
updatecli apply \
  --config updatecli.d/open-release-pr.yaml \
  --values values.yaml \
  --debug --clean=true
```
