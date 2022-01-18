################################################################################################################
# Shell Script to execute the Ansible Playbook file for Installation of services on Hosts & ECR Authentication #
################################################################################################################
#!/bin/sh
echo "Running Ansible Playbooks"
cd /etc/ansible/
echo "Checking the connection to hosts"
sudo ansible all -m ping -i hosts

echo "Running the Ansible-Playbook to install Docker on Jenkins & App Host , Jenkins on Jenkins Host & ECR Authentication on Jenkins & App Host"
sudo ansible-playbook -v -i hosts /mnt/c/Users/Ashwini/Desktop/Course_Project/PGC_DevOps_CICDSPCMProject/Scripts/T2_*.yaml
