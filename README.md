Simple terraform state to automate certain tasks:

  * Ensure all the members of the `kubewarden-develoepers` team have `push` access
    to all the repositories of the organization

## Usage

* Create your own GitHub Personal Access Token (PAT)
* Pass the token via an environment variable or by writing that into the `terraform.tfvars` file
  (this file is on the ignore list of git)
* `terraform init && terraform apply`
# terraform-automation
