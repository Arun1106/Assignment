# Overview
This Terraform project creates and manages the sample web application.
# Requirement
To use this Terraform project, you'll need to have the following installed:
1. Terraform (version 0.12 or higher)<br>
2. AWS CLI (for AWS projects)<br>
# Authentication
  As a first step kindly authtenticate using aws cli command `aws configure` by required values.<br>
# Setup
   1. Clone this repository to your local machine
   `git clone`<br>
   2. Run terraform init to initialize the project
     `terraform init`<br>
   3. Update the dev.tfvars file with the appropriate values<br>
   4. Run terraform plan to preview the changes that will be made<br>
      `terraform plan -var-file="./tfvars/dev.tfvars"`<br>
   5. Run terraform apply to apply the changes and create the infrastructure
      `terraform apply -var-file="./tfvars/dev.tfvars"`<br>
# Usage
To use this Terraform project, simply run terraform apply after updating the dev.tfvars file with the appropriate values.
# Resource
[Terraform documentation](https://www.terraform.io/docs/index.html)<br>
[AWS documentation](https://docs.aws.amazon.com/index.html)
