#####################################################################
#  Shell Script to download and install Terraform over the localhost.#
#####################################################################
#!/bin/sh
#Installing Terraform
echo "Installing Terraform on Local Linux Machine."
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform

pwd



