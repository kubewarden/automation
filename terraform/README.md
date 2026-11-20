# Terraform configuration for the Kubewarden GitHub organization

The files in this directory manage the repositories of the `kubewarden`
organization on GitHub.

For each repository, Terraform manages these items:

- The configuration of the repository (description, homepage, topics, merge methods)
- The standard issue labels
- The entry of the repository in the DCO GitHub App
- The vulnerability alerts
- The `push` permission of teams, if the declaration names teams

Do not create a repository by hand in the GitHub web UI. Declare the repository
in the applicable file. Then ask an owner of the organization to run
`terraform apply`.

## Files

| Type of repository | File                            | Module                               |
|--------------------|---------------------------------|--------------------------------------|
| Core component     | `repository_core.tf`            | `modules/repository`                 |
| Policy             | `repository_policies.tf`        | `modules/policy_repository`          |
| Policy SDK         | `repository_policy_sdk.tf`      | `modules/repository`                 |
| Policy template    | `repository_policy_template.tf` | `modules/policy_template_repository` |
| Other              | `repository_others.tf`          | `modules/repository`                 |

## Before you start

1. Create a GitHub Personal Access Token (PAT) with an account that is an owner
   of the organization.
2. Write the token in the `terraform.tfvars` file. Git ignores this file.

   ```hcl
   token = "<your token>"
   ```

3. Run `terraform init`.

## State file

The state file is the record of the resources that Terraform manages. The state
file is `terraform.tfstate`. We keep this file in git.

After each command that changes the state file, commit the file and push it.
These commands are `terraform apply` and `terraform state rm`. If you do not
commit the file, the next person starts from an old state file.

## Topics

The `modules/repository` module gives these base topics to each repository:
`hacktoberfest`, `kubernetes`, `kubernetes-security`, `policy-as-code`.

Two attributes change the topics of a repository:

- `extra_topics` adds topics to the base topics
- `topics` replaces the base topics

The modules for policies and for policy templates have their own base topics.
These two modules accept only `extra_topics`.

## Add a new repository

1. Find the file for the type of repository in the table.
2. Copy the declaration of a similar repository.
3. Change the name of the module and the `name` attribute.
4. Run `terraform plan`.
5. Make sure that the plan creates only the resources of the new repository.
6. Run `terraform apply`.
7. Commit the changes and the state file. Then push.

## Import a repository that exists on GitHub

An import adds a resource that exists on GitHub to the state file. The import
does not change the resource.

A repository that exists has some of the resources that the module declares.
You must import each of these resources. If you do not import a label that
exists, `terraform apply` fails, because GitHub does not accept two labels with
the same name.

| Resource        | Address in the module                                     | Import ID                |
|-----------------|-----------------------------------------------------------|--------------------------|
| Repository      | `github_repository.main`                                  | `<repository>`           |
| DCO GitHub App  | `github_app_installation_repository.app_dco`              | `29141080:<repository>`  |
| Issue label     | `github_issue_label.label["<label>"]`                     | `<repository>:<label>`   |
| Team permission | `github_team_repository.gh_team_push_rights["<team ID>"]` | `<team ID>:<repository>` |

The `issue_labels` variable of each module lists the standard labels. This
command shows the labels that a repository has:

```console
gh label list --repo kubewarden/<repository>
```

Do these steps:

1. Declare the repository in the applicable file.
2. Give each attribute the value that the repository has on GitHub.
3. Create a temporary `imports.tf` file with one `import` block for each resource.
4. Run `terraform plan`.
5. Read the plan. If the plan changes a value that must stay, change the declaration.
6. Do steps 4 and 5 again until the plan is correct.
7. Run `terraform apply`.
8. Delete the `imports.tf` file.
9. Commit the changes and the state file. Then push.

### Example

This `imports.tf` file imports the `gateway-protector` repository. The
repository had five of the standard labels before the import.

```hcl
import {
  to = module.kubewarden_gateway_protector_repository.github_repository.main
  id = "gateway-protector"
}

import {
  to = module.kubewarden_gateway_protector_repository.github_app_installation_repository.app_dco
  id = "29141080:gateway-protector"
}

import {
  for_each = toset([
    "area/dependencies",
    "kind/bug",
    "kind/chore",
    "good first issue",
    "help wanted",
  ])
  to = module.kubewarden_gateway_protector_repository.github_issue_label.label[each.key]
  id = "gateway-protector:${each.key}"
}
```

## Remove a repository

Remove a repository from Terraform when the organization archives it. This
procedure does not change the repository on GitHub.

1. Run `terraform state rm module.<name of the module>`.
2. Delete the declaration of the module.
3. Run `terraform plan`.
4. Make sure that the plan shows no changes for the repository.
5. Commit the changes and the state file. Then push.

CAUTION: Do step 1 before step 2. If you delete the declaration first, Terraform
tries to destroy the repository and `terraform plan` fails.

## Known issues

- Each declaration names the instance of the `github` provider. The
  `terraform import` command did not work without these lines.
- The three modules contain duplicate code. The name of the module is part of
  the address of each resource. As a result, a merge of the modules makes a new
  import of each repository necessary.
- Terraform shows a deprecation warning for the `pages` block of four
  repositories: `docs`, `kubewarden.io`, `policy-hub`, and `policy-sdk-swift`.
  The provider recommends the `github_repository_pages` resource as the
  replacement.
