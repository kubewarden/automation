This repository contains script to automate certain tasks in Kuberwarden project.

The directory structure is organized in two major subdirectories. 
The `terraform` directory has Terraform scripts to ensure all the members of the 
`kubewarden-develoepers` team have `push` access to all the repositories of 
the organization. 
The `scripts` directory has other standalone script to automate other things 
in the organization. 

## Terraform Usage

* Create your own GitHub Personal Access Token (PAT)
* Pass the token via an environment variable or by writing that into the `terraform.tfvars` file
  (this file is on the ignore list of git)
* `terraform init && terraform apply`


## Script Usage

* Create your own GitHub Personal Access Token (PAT)
* Install the dependencies defined in the `requirements.txt` file:
  ```
  pip install -r requirements.txt --user
  ```
* Check how to use the script via `-h` command line flag and use it!

