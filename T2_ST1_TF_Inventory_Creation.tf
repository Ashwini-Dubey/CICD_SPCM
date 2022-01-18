################################################################################################
# Creating the Dynamic Inentory/Hosts file on the local machine after the Ansible Installation #
################################################################################################
resource "local_file" "ansible_inventory" {
  content = templatefile("T2_ST1_Ansible_Inventory_Template.tmpl", {
      app_host_ip = aws_instance.app_host.private_ip,
      bastion_host_ip = aws_instance.bastion_host.public_ip,
      jenkins_host_ip = aws_instance.jenkins_host.private_ip,
      ssh_keyfile = file("project_key.pem")      
  })

  filename ="/etc/ansible/hosts"
}