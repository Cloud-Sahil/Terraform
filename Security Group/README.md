# Terraform Script to deploy Security Groups
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
 - "~" resource to be change
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
### Write tf.file
```hcl
nano sg.tf
```
```hcl
provider "aws" {
  region = "ap-south-1" # Replace with your desired AWS region
}
resource "aws_security_group" "newsg" {
  description = "Allow http and ssh pots inbound traffic and all outbound traffic"
  vpc_id      = "vpc-028aec56b3680bb0e"   # Replace with your default vpc id
  tags = {
    Name = "new-sg"
  }
}


resource "aws_vpc_security_group_ingress_rule" "test-sg" {
  security_group_id = aws_security_group.newsg.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "sshest-sg" {
  security_group_id = aws_security_group.newsg.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 21
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "egress-tg" {
  security_group_id = aws_security_group.newsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
```
### Intitlize terraform in current directory
```hcl
terraform init
```
### Gives blueprint of resources which are going to be create
```hcl
terraform plan
```
### Validate the code
```hcl
terraform validate
```
### Gives allingment to terraform.tf files
```hcl
terraform fmt
```
### Apply change and approve them
```hcl
terraform apply --auto-approve
```
### Delete
```hcl
terraform destroy
```
---
