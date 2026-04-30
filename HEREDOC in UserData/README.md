# HEREDOC in UserData
## What is HEREDOC?
HEREDOC **(Here Document)** is a multi-line string syntax in Terraform used to define large blocks of text or commands. It is often utilized in `UserData` to pass startup scripts to cloud instances.

### Example with UserData
Below is an example of using HEREDOC within an EC2 instance resource:
```hcl
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}
```
```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-12345678" # Your AMI ID
  instance_type = "t3.micro"

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    echo "Hello, World!" > /var/www/html/index.html
    systemctl start httpd
    systemctl enable httpd
  EOF

  tags = {
    Name = "web-server"
  }
}
```

### Another Example:

```
user_data = <<EOF
  ${file("index.sh")}
  EOF
```

### HEREDOC Syntax
- **`<<-EOF`**: Begins the HEREDOC. The `-` allows indentation.
- **Content**: The script or text.
- **`EOF`**: Ends the HEREDOC block.

---
