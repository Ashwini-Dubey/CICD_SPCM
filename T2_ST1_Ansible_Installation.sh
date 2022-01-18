####################################################################################
#           Subtask 1 : Ansible Installation on the local Linux machine.           #
####################################################################################
#!/bin/bash
sudo apt update
echo "Installing Ansible"
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
