# Terraform Create Ec2 (Elastic Compute Cloud) Instances 
---
## Create EC2 Instances 
 - Connect
## Commands
```hcl
sudo -i
```
```hcl
apt update
```
### Terraform install
```hcl
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
 - "+" resource to be created
 - "-" resource to be deleted
 - "~" resource to be chnage
### Install AWS Cli
```hcl
snap install aws-cli --classic
```
### Aws Configure
```hcl
aws configure
```
 - Access key ID
 - Secret access key

### Write Tf File
```hcl
nano main.tf
```
```hcl
# Define the AWS provider
provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

# Create an EC2 instance
resource "aws_instance" "my-ec2" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"

  tags = {
    Name = "MyFirstEC2"
  }
}
```
