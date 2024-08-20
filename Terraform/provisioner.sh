#!/bin/bash

# Update and install dependencies
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl unzip gnupg software-properties-common apt-transport-https wget

# Install Terraform
echo "Installing Terraform..."
TERRAFORM_VERSION="1.5.7"  # Specify the Terraform version you want to install
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
echo "Terraform installed successfully."

# Install Jenkins
echo "Installing Jenkins..."
sudo apt update
sudo apt install openjdk-11-jdk -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update

sudo apt install jenkins -y

sudo systemctl start jenkins

sudo systemctl enable jenkins

# Display Jenkins initial password
echo "Jenkins initial setup password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Jenkins and Terraform installation completed."
