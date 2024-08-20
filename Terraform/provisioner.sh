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
