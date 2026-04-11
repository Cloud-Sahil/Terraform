# Terraform 
 - **Infrastructure As Code**
 - **Open Source Code**
---



# Infrastructure as Code (IAC) & Terraform Basics

##    Introduction to IAC
- **Definition**: IAC means writing **code** (instead of clicking manually in AWS/Azure GUI) to create and manage infrastructure like servers, networks, databases, etc.  
- **Idea**: Just like you use code to build an app, you use code to build infrastructure.  
- **Benefits**:  
  - Repeatable → Same setup every time.  
  - Automated → Saves manual effort.  
  - Version-controlled → Stored in Git, so changes are trackable.  
  - Scalable → Easy to deploy infra across multiple environments (Dev, Test, Prod).  

- Example: Instead of manually creating an EC2 in AWS Console, you write a Terraform file and just run `terraform apply`.

---

##  Why we need IAC (Difference between Shell Script, Ansible, and IAC tools like Terraform)

| **Aspect** | **Shell Script** | **Ansible** | **IAC Tool (Terraform)** |
|------------|------------------|-------------|--------------------------|
| **Type** | Scripting language (Bash, etc.) | Configuration Management & Automation Tool | Infrastructure as Code (IaC) Tool |
| **Purpose** | Automate tasks | Configure & manage servers | Provision infrastructure |
| **Scalability** | Low | High | Very High
| **State awareness** | No state awareness → runs blindly. | Limited state tracking. | Maintains **state file** → knows what exists and what needs change. |
| **Idempotency** |  No → may create duplicates. |  Yes → ensures final state. |  Yes → ensures infrastructure matches code. |
| **Cloud support** | No direct support | Limited (via modules/plugins) | Strong (AWS, Azure, GCP, etc.)|
| **Best For** | Quick scripts | Config management | Infrastructure automation |
| **Example** | Bash script: `apt-get install nginx` | Ansible Playbook to install Nginx | Terraform code to create EC2 + attach security group + install Nginx |

- In short:  
  - **Shell Script** = manual automation.  
  - **Ansible** = config management & software deployment.  
  - **Terraform (IAC)** = provisioning complete infra in a controlled, declarative way.  

---


##  Terraform Language (Basic Syntax)
Terraform files are written in **HCL (HashiCorp Configuration Language)**.  

Example:
```hcl
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

resource "aws_instance" "my-ec2" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
}
```

- **Provider** → Defines which cloud/service you are using (AWS, Azure, GCP).  
- **Resource** → Defines what infra you want (EC2, VPC, S3, etc.).  
- **Arguments** → Settings inside resources (`ami`, `instance_type`).  

  - It’s **declarative** → you say *what you want*, Terraform figures out *how to do it*.  

---

##  Enlist the Blocks used in Terraform Language

Terraform has multiple **blocks** (building units):  

1. **provider** → Defines the provider (AWS, Azure, etc.)  
   ```hcl
   provider "aws" {
     region = "us-east-1"  # Replace with your desired AWS region
   }
   ```

2. **resource** → Defines infrastructure resources.  
   ```hcl
   resource "aws_instance" "example" {
     ami           = "ami-12345"
     instance_type = "t3.micro"
   }
   ```

3. **variable** → Input values (like parameters).  
   ```hcl
   variable "region" {
     default = "us-east-1"   # Replace with your desired AWS region
   }
   ```

4. **output** → Shows values after deployment.  
   ```hcl
   output "instance_ip" {
     value = aws_instance.example.public_ip
   }
   ```

5. **data** → Fetch existing info (e.g., latest AMI).  
   ```hcl
   data "aws_ami" "latest" {
     most_recent = true
     owners      = ["amazon"]
   }
   ```

6. **module** → Group of Terraform files reused as a package.  
   ```hcl
   module "vpc" {
     source = "./modules/vpc"
   }
   ```

7. **locals** → Define local variables.  
   ```hcl
   locals {
     env = "dev"
   }
   ```
---
## Terraform stages (workflow steps) & Lifecycle =
### 1. Init Stage (`terraform init`)
 - Initializes the working directory
 - Downloads required **providers** (AWS, Azure, etc.)
 - Sets up backend (for state storage)
 - Prepares Terraform to run

### 2. Plan Stage (`terraform plan`)
 - blueprint of infra after apply
 - Compares **current state vs desired state**

### 3. Apply Stage (`terraform apply`)
 - Executes the changes from the plan
 - Creates/updates infrastructure
 - Updates the **state file** (`.tfstate`)

### 4. Destroy (`terraform destroy`)
 - Deletes all created infrastructure
---

## Difference between CloudFromation Vs Terraform

| **Feature** | **CloudFormation** | **Terraform** | 
|------------|------------------|-------------|
| **Developer** | Amazon Web Services | HashiCorp | 
| **Cloud Support** | AWS only | Multi-cloud (AWS, Azure, GCP, etc.) |
| **Language** | JSON / YAML | HCL (HashiCorp Configuration Language) |
| **Multi-Cloud Capability** | ❌ Not supported |  ✅ Strong support |
| **State Management** | Managed by AWS (no local file needed) | Uses `.tfstate` file (local/remote) |
| **Example** | Create EC2, S3 inside AWS only | Create AWS EC2 + Azure VM + GCP storage together |

---
