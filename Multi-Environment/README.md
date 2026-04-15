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
