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
  region = "us-east-1"
}

resource "aws_instance" "my-ec2" {
  ami           = "ami-05d2d839d4f73aafb"  # Amazon Linux 2 AMI
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
