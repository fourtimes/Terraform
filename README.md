## Terraform

HashiCorp Terraform is an infrastructure as code (IaC) software tool that allows DevOps teams to automate infrastructure provisioning using reusable, shareable, human-readable configuration files. The tool can automate infrastructure provisioning in both on-premises and cloud environments.

![image](https://github.com/fourtimes/Terraform/assets/91359308/269ceb1b-219b-458a-9b5b-e949be0603e4)


## Terraform Architecture

Core ===> config.tf, state file

Providers ===> AWS, GCP, AZURE,...........100+

## Terraform platform
|service|Infra|
|-------|------|
|AWS && Azure && GCP   | IAAC (Insfrastrucre as a code)|
|K8s,.......           | PAAS (Platform as a service)|
|Github, Bitbuket,.... | SAAS (Software as a service)|
## Define IAC?

**IAC or Infrastructure as Code** allows you to build, change, and manage your infrastructure through coding instead of manual processes. The configuration files are created according to your infrastructure specifications and these configurations can be edited and distributed securely within an organization.
## What are the most useful Terraform commands?

**terraform init** - initializes the current directory

**terraform plan** - a dry run to see what Terraform will do

**terraform apply** - applies the Terraform code and builds stuff

**terraform destroy** - destroys what has been built by Terraform

**terraform refresh** - refreshes the state file

**terraform output** - views Terraform outputs

**terraform graph** - creates a DOT-formatted graph
