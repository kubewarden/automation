These are a series of scripts that can be used to deal with ArtifactHub

## Migrate from Policy Hub to ArtifactHub package metadata

This script is used for migrating from the old Policy Hub `hub.yml` file
to the metadata file used by ArtifactHub.

The name of the script is `policyhub2artifacthub`.

### Requirements

* Ruby

### Usage

The [ArtifactHub pkg metadata](https://github.com/artifacthub/hub/blob/master/docs/metadata/artifacthub-pkg.yml)
can be generated in this way:

```console
policyhub2artifacthub --policy-version <git tag>
```

This will print the ArtifactHub metadata to the standard out.

The `artifacthub-pkg.yml` file can be automatically created using the `-w` flag:

```console
policyhub2artifacthub -w --policy-version <git tag>
```

**WARNING:** don't forget to double check the generated file.

## Publish policy to ArtifactHub

This script is used to publish a Kubewarden policy on ArtifactHub.

The name of the script is `publish-to-artifacthub`.

### Requirements

* Ruby
* Obtain a [ArtifactHub API key](https://artifacthub.io/control-panel/settings/api-keys)
* Export the `API-KEY-ID` and the `API-KEY-SECRET` with these environment variables:
  * `API_KEY_ID`
  * `API_KEY_SECRET`
* Ensure the `artifacthub-pkg.yml` is available on the Git repository

### Usage

The program takes these flags:

  * `--name` [optional]: name of the ArtifactHub Repository that is going to be created.
    Usually that's equal to the name of the GitHub repository. When not supplied,
    the program will load it from the `artifacthub-pkg.yml` file.
  * `--display-name` [optional]: A "beautified" version of the GitHub repository name.
    When not supplied, the program will load it from the `artifacthub-pkg.yml` file.
  * `--url` [optional]: URL to the GitHub repository. This is the same URL you put inside of
    your browser. When not supplied, the program will load it from the
    `artifacthub-pkg.yml` file.
  * `--branch` [optional]: name of the Git branch. By default `main` is used.
  * `--organization` [optional]: name of the ArtifactHub Organization that will
    own the ArtifactHub repository. By default the repository will be owned by
    the same user that authenticates against ArtifactHub.

Some notes about the ownership of the ArtifactHub repository. It's always possible
to transfer the ownership of a repository from an user to an organization and
vice versa.

Finally, the Kubewarden organization is called `kubewarden`, but you must be part
of it in order to submit repository beneath it.

Submitting the repository to ArtifactHub, under the Kubewarden organization:

```console
publish-to-artifacthub -o kubewarden
```

## Generate ArtifactHub Repository metadata

ArtifactHub repositories can have a "verified publisher" badge. This badge is
granted when the Git repository holding the `artifacthub-pkg.yml` file
features also a
[`artifacthub-repo.yml`](https://github.com/artifacthub/hub/blob/master/docs/metadata/artifacthub-repo.yml)
file.

The `generate-artifact-hub-repo-metadata` script can create this file.

> **Note:** the `artifact-repo.yml` has to be created once. It doesn't need to
> be changed later on, even after new policy tags are created.

### Requirements

* Ruby
* The ArtifactHub repository has been created

### Usage

The program takes these flags:

  * `--name` [optional]: name of the ArtifactHub Repository that is going to be created.
    Usually that's equal to the name of the GitHub repository. When not supplied,
    the program will load it from the `artifacthub-pkg.yml` file.
  * `--user` [optional]: the name of the ArtifactHub user who owns the repository.
  * `--organization` [optional]: name of the ArtifactHub Organization that owns
    the repository.

The script will query the ArtifactHub API looking for the ArtifactHub repository.

You must supply either a `user` or an `organization`, both can be supplied at the
same time.

This will generate the `artifacthub-repo.yml` file, using the metadata
retried from ArtifactHub:

```console
generate-artifact-hub-repo-metadata -o kubewarden
```

This will print the contents to the standard output. The `-w` flag can
be used to write it to `artifacthub-repo.yml` file:

```
generate-artifact-hub-repo-metadata -o kubewarden -w
```

