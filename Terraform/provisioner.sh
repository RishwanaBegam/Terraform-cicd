#!/bin/bash

# Download Terraform
TERRAFORM_VERSION="1.5.0"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
echo "---------------------------------------Terraform Download Complete--------------------------------------------"

# Install unzip if not present
sudo yum install unzip -y
echo "---------------------------------------Unzip installation Complete--------------------------------------------"
# Unzip and move to /usr/local/bin
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Verify installation
terraform --version
echo "---------------------------------------Terraform Installation Complete--------------------------------------------"


echo "********************************************************************************"
# Update the package manager
sudo yum update -y

# Install Java (Jenkins dependency)
sudo amazon-linux-extras install java-openjdk11 -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
sudo yum install jenkins -y
echo "Installing jenkins ..."
# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Open port 8080 in the firewall
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

echo "---------------------------------------Jenkins Installation Complete--------------------------------------------"
