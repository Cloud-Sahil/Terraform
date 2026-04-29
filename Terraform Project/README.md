# Terraform Project
## 1. EC2 (Elastic Compute Cloud)

. Launch instance

. Instance type -- EX. (c7i-flex.large)

. Security groups -- EX. (launch-wizard-1)

. Storage -- EX. (20GB)

. Launch instance

---


## 2. Commands =

###  Switch to root user
```sh
sudo -i
```


###  Update the instance
```sh
apt update
```
### Terraform installation 

```sh
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```
## update the repo and install the terraform 
```bash
sudo nano /etc/apt/sources.list.d/hashicorp.list
```
```bash
deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com jammy main
```
```bash
sudo apt update -y
sudo apt install terraform

```
###  Clone the GitHub Repository
```sh
git clone <GitHub_Repository_Link>
```
#### Example: git clone https://github.com/mukundDeo9325/Super-Mario.git
