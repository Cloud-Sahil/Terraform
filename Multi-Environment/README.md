# Terraform Multi-Environment Setup using `.tfvars` and Workspaces
This project demonstrates how to manage **multiple environments (dev, stage, prod)** using a **single Terraform codebase** with environment-specific `.tfvars` files and Terraform workspaces.

This is a **production-grade DevOps pattern** used to avoid code duplication and safely isolate environment

---
## Why Use Multi-Environment with .tfvars?
**Instead of maintaining separate Terraform code for each environment:**

 - Single Terraform codebase
 - Environment-specific inputs via `.tfvars`
 - Separate state per environment using workspaces
 - Easy scalability and maintenance
**Benefits**
 - Clean repository
 - Fewer configuration errors
 - Industry best practice
 - Interview-friendly design
---

## **Project Structure**
```hcl
ec2-multi-env/
├── main.tf
├── variables.tf
├── workspace/
│   ├── dev.tfvars
│   ├── stage.tfvars
│   └── prod.tfvars
```
### 1️ main.tf
Defines the AWS provider and EC2 resource. The same code runs in all environments.
```hcl
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

resource "aws_instance" "my-ec2" {
  ami           = "ami-05d2d839d4f73aafb"  
  instance_type = var.instance_type

  tags = {
    Name = "ec2-${terraform.workspace}"
    Env  = terraform.workspace
  }
}
```
**Explanation** terraform.workspace dynamically identifies the active environment

Tags automatically change based on environment

### 2️. variables.tf
Declares reusable input variables.
```hcl
variable "instance_type" {
  description = "EC2 instance type per environment"
  type        = string
}
```
### 3️. Environment-Specific .tfvars
Each environment overrides only required values.
- **workspace/dev.tfvars**
```hcl
instance_type = "t2.micro"
```
- **workspace/stage.tfvars**
```hcl
instance_type = "t3.small"
```
 - **workspace/prod.tfvars**
```hcl
instance_type = "t3.medium"
```
### 4. Terraform Workflow Commands
- **Initialize Terraform**
```hcl
terraform init
```
- **Create Workspaces**
```hcl
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
```
- **Deploy Dev Environment**
```hcl
terraform workspace select dev
terraform apply -var-file="workspace/dev.tfvars"
```
- **Deploy Stage Environment**
```hcl
terraform workspace select stage
terraform apply -var-file="workspace/stage.tfvars"
```

- **Deploy Prod Environment**
```hcl
terraform workspace select prod
terraform apply -var-file="workspace/prod.tfvars"
```
`Each workspace has a separate state file, preventing cross-environment conflicts.`

---

## Commands 
```hcl
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
terraform workspace list
nano main.tf
nano variable.tf
mkdir workspace
cd workspace/
nano dev.tfvars   # Instances Type
nano stage.tfvars   # Instances Type
nano prod.tfvars   # Instances Type
cd
terraform workspace list
terraform workspace select dev
terraform apply -var-file ="workspace/dev.tfvars"
terraform workspace select stage
terraform apply -var-file ="workspace/stage.tfvars"
terraform workspace select prod
terraform apply -var-file ="workspace/prod.tfvars"
```
