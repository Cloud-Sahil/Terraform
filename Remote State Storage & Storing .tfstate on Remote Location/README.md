# Remote State Storage & Storing .tfstate on Remote Location
## Why Store State Remotely?
 - Storing the state file remotely enables team collaboration.
 - Provides state locking to prevent conflicts during simultaneous updates.
 - Secures sensitive data stored in the state file.
---
## Create EC2 In.
## Command
### 1. Switch to root user
```sh
sudo -i
```


### 2. Update the instance
```sh
apt update
```
### 3. Install AWS CLI on Ubuntu
```sh
snap install aws-cli --classic
```

### 4. Configure AWS CLI
```sh
aws configure
```

#### Access key ID
#### Secret access key

### 5. Terraform Instalation
```sh
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
### 6. Create Key
```sh
nano <place your key>
```
```sh
<key content>
```
### Create tf.file
```sh
provider "aws" {
  region = "ap-northeast-1" # region 
}

resource "aws_instance" "web" {
  ami           = "ami-0f8faa29480e7e6de"  # # Your Ami ID
  instance_type = "t3.micro"
  key_name = "abc"  # Your Key name
  provisioner "local-exec" {
    command = "touch abc"
  }

  provisioner "file" {
    source      = "nginx.sh"
    destination = "/home/ubuntu/nginx.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("abc") # Your Key name
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/nginx.sh",
      "bash /home/ubuntu/nginx.sh"
    ]
  }
  tags = {
    Name = "WebServer"
  }
}
```
```sh
terraform init
```
```sh
terraform fmt
```
```sh
terraform plan
```
```sh
terraform apply --auto-approve
```
```sh
terraform destroy --auto-approve  # `Do not use this commands in company`
```
