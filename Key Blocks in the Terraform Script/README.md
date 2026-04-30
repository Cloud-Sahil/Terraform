# Key Blocks in the Terraform Script
## Provider Block
The `provider` block specifies the cloud provider to manage resources.

### Example:
```hcl
provider "aws" {
  region = "us-east-1"
}
```
- **`region`**: Defines the AWS region for resource deployment.

## Resource Block
The `resource` block defines the actual infrastructure components.

### Example:
```hcl
resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  description = "Allow inbound HTTP and SSH traffic"
}
```
- **`name_prefix`**: Prefix for the Security Group name.
- **`ingress`/`egress`**: Rules for inbound and outbound traffic.

## Variable Block
The `variable` block is used to parameterize values, making the script reusable.

### Example:
```hcl
variable "region" {
  default = "us-east-1"
}
```
- **`default`**: Specifies a default value.

## Data Block
The `data` block retrieves existing resources.

### Example:
```hcl
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["self"]
}
```
- **`most_recent`**: Fetches the latest AMI.

## Output Block
The `output` block displays resource attributes after execution.

### Example:
```hcl
output "security_group_id" {
  value = aws_security_group.web_sg.id
}
```
- **`value`**: Specifies the attribute to output.

---
