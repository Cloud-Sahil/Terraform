# Terraform Loops
Terraform supports multiple looping mechanisms to create and manage resources efficiently.

## 1️. `count`
Creates multiple identical resources using a numeric value.

**Best Use**

 - Same configuration

 - Fixed number of resources

**Example**
```hcl
resource "aws_instance" "example" {
  count         = 3
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```
- Access Instances
```hcl
aws_instance.example[0]
aws_instance.example[1]
aws_instance.example[2]
```
`Index-based addressing may cause issues if resources are removed.`

## 2️. `for_each`
Creates resources from a map or set with stable identifiers.

**Best Use**
 - Environment-specific resources

 - Unique configurations

**Example**
```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  for_each = {
    dev  = "dev-bucket-unique-1"
    prod = "prod-bucket-unique-2"
  }

  bucket = each.value

  tags = {
    Env = each.key
  }
}
```
-  Access Resources
```hcl
aws_s3_bucket.example["dev"]
aws_s3_bucket.example["prod"]
```
`Preferred over count in real-world infrastructure.`

## 3️. `for`
Used to transform or filter data, not create resources.

**Transform Example**
```hcl
variable "names" {
  default = ["Alice", "Bob", "Charlie"]
}

output "uppercase_names" {
  value = [for name in var.names : upper(name)]
}
```
Output
```hcl
["ALICE", "BOB", "CHARLIE"]
```
- Filtering Example
```hcl
output "filtered_names" {
  value = [for name in var.names : name if length(name) > 3]
}
```
Output
```hcl
["Alice", "Charlie"]
```

## Loop Comparison Table
Terraform provides three primary looping mechanisms: `count`, `for_each`, and `for`.
Each serves a different purpose and should be chosen carefully based on the use case.

| Feature / Aspect         | `count`                     | `for_each`                | `for`           |
| ------------------------ | --------------------------- | ------------------------- | -------------------------- |
| **Loop Type**            | Meta-argument               | Meta-argument             | Expression                 |
| **Input Type**           | Number                      | Map or Set                | List, Map, or Set          |
| **Purpose**              | Create identical resources  | Create unique resources   | Transform or filter data   |
| **Resource Creation**    | Yes                         | Yes                       | No                         |
| **Resource Addressing**  | Index-based (`[0]`, `[1]`)  | Key-based (`["dev"]`)     | Not applicable             |
| **Stability**            | Less stable                 | Highly stable             | Stable                     |
| **Best Use Case**        | Same config, fixed quantity | Real-world infrastructure | Outputs, locals, variables |
| **Recommended for Prod** | Avoid when possible         | Yes                       | Yes                        |
| **Example Usage**        | EC2 instances scaling       | Env-based resources       | Data transformation        |

---
## Recommendation
 - Use **`for_each`** for most real-world infrastructure
 - Use **`count`** only for simple, identical resources
 - Use **`for`** **expressions** for transforming and filtering data
---
#  Terraform Commands

## 1. **Taint Command**
The `taint` command marks a resource for recreation during the next `terraform apply`. This is useful when a specific resource needs to be replaced without altering the rest of the infrastructure.

### **Syntax:**
```bash
terraform taint <resource_name>
```

### **Example:**
```bash
terraform taint aws_instance.my_instance
```
This marks the `aws_instance.my_instance` resource for recreation.


## Terraform command 
### `terraform taint` command --> `terraform replace` command command is used v0.15.2
- if you have made lots of manual changes to terraform /delete / recrete resources
- `terraform apply -replace "aws_instance.my-ec2"` --> to distroy and create an new ec2 instance of privious version that terraform had 

---

## 2. **Import Command**
The `import` command allows importing existing infrastructure resources into Terraform state. This is helpful when managing resources created outside of Terraform.

### **Syntax:**
```bash
terraform import <resource_type>.<resource_name> <resource_id>
```

### **Example:**
```bash
terraform import aws_instance.my_instance i-qwe12345
```
This imports the AWS EC2 instance with ID `i-qwe12345` into Terraform as `aws_instance.my_instance`.

---

## 3. **Destroy Command**
The `destroy` command removes all resources defined in the configuration.

### **Targeted Destroy (-t)**
You can destroy specific resources using the `-target` flag.

### **Syntax:**
```bash
terraform destroy -target=<resource_type>.<resource_name>
```

---
