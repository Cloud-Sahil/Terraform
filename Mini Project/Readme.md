# Mini Project
 - AutoScalingGroups (ASG)
 - Ec2
 - Load Balancer (ALB)
 - Launch Templates
 - Target Groups (with health checks)
 - Scaling Policies
---
## Create EC2 In.
---
## Commands
```sh
sudo -i
```
```sh
apt update
```
```sh
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
```sh
snap install aws-cli --classic
```
```sh
aws configure
```

