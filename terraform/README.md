This directory contains a series of terraform states that are used
to manage the Kubewarden organization on GitHub.

The terraform states currently manage these resources:

# Repositories

> **WARNINING:** do **not** create new repositories by hand, using the GitHub
> web UI.
> Instead, declare a new repository inside of the appropriate file and
> then ask one of the owners of the organization to run a `terraform apply`.

This terraform-based automation is able to handle these kind of repositories:


| Purpose         | File to be changed              |
|-----------------|---------------------------------|
| Policy          | `repository_policies.tf`        |
| Policy SDK      | `repository_policy_sdk.tf`      |
| Policy Template | `repository_policy_template.tf` |

## Importing an already existing repository

Importing an already existing repository into terraform is possible,
these are the steps to follow.

  1. Identify the file to change. See the table from above
  1. Copy the snippet that declares a policy repository. Ensure you pick
     a unique terraform identifier, plus change the repository name.
  1. Run the `terraform init` command
  1. Import the repository via `terraform import module.<type of repository>.github_repository.main "<unique id>"`
  1. Run `terraform plan`
  1. Look at what terraform would change, do the proper changes to the
     repository definition inside of terraform
  1. Run `terraform apply`. Please **read carefully** all the operation terraform
     would do. A repository might be **permanently deleted** by terraform. Please
     double check what is going to be done!
  1. Apply the changes proposed by terraform
  1. Commit all the changes to git, especially the ones done to the `*.tfstate*`
    files
  1. Push the changes to GitHub

As a concrete example, let's add a new repository called `kubewarden/safe-labels-policy`.

We start by editing the `repository_policies.tf` files. We copy the snippet
defining an already known repository `policy_repository_safe_annotations_policy`:

```hcl
module "policy_repository_safe_annotations_policy" {
  source = "./modules/policy_repository"

  name                   = "safe-annotations-policy"
  description            = "Kubewarden policy that validates Kubernetes' resource annotations"
  extra_topics           = [ "kubernetes-compliance" ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}
```

We declaring a new repository object for `kubewarden/safe-labels-policy` by copy
and pasting the previous snippet with some minor changes:

```hcl
module "policy_repository_safe_labels_policy" {
  source = "./modules/policy_repository"

  name                   = "safe-labels-policy"
  description            = "Kubewarden policy that validates Kubernetes' resource annotations"
  extra_topics           = [ "kubernetes-compliance" ]
  teams_with_push_rights = [ data.github_team.kubewarden_developers.id ]

  providers = {
    github = github.kubewarden
  }
}
```

We basically changed the name of the terraform resource to be
`policy_repository_safe_labels_policy`. We also changed the `name` attribute.

We can now run:

```console
terraform init
terraform import \
  module.policy_repository_safe_labels_policy.github_repository.main \
  "safe-labels-policy"
```

It's really important to provide the right input to the `terraform import` command:

  * 1st param - resource name: the string `policy_repository_safe_labels_policy` references the
    name of the resource that we just defined
  * 2nd param - unique terraform id: this must be the name of the repository as
    declared inside of GitHub.
    You do not have to provide the organization name, the code automatically adds it.

Once this command is done, the current values of the `kubewarden/safe-labels-policy`
repository are going to be known by terraform.

Because of that, running the following code will report a configuration drift:

```console
terraform plan
```

You will notice some of the known attributes of the repository are going to be
changed to reflect what is declared inside of the `repository_policies.tf` file.

For example, the `description` and the `template` attributes will change. Probably
some `topics` will change too.
Some of these changes are good (the new tags), while others are bad (the description
and the template ones).

Keep iterating over these steps until terraform produces a satisfying plan:

  1. Change the declaration of the repository inside of the terraform file
  1. Run `terraform plan`

Once everything is set, run `terraform apply`. Again, be 100% sure about the changes
terraform will perform.

## Known issues

We have used terraform modules to reduce the boilerplate. This is great, but has
some drawbacks too:

* The resources and the modules have to be explicit about which instance of the `github`
  provider has to be used. In theory this is not needed, however the `terraform import`
  didn't work without these extra lines.
* There's some duplication between the different type of repositories the modules
  define. We could maybe come up with a single repository module definition. However
  we would then have to reimport all the repositories that are already known.
  That's because the name of the module is part of the repository ID. This would
  be a major PITA, plus we might risk to accidentally delete a repository if we
  are not extra careful.


