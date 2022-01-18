#####################################################################################################
# Local Executable to execute the Ansible Installation with the T2_ST1_Ansible_Installation script. #
#####################################################################################################
resource "null_resource" "ansible_installation" {
provisioner "local-exec" {
        command = "bash T2_ST1_Ansible_Installation.sh"
        interpreter = ["/bin/sh" ,"T2_ST1_Ansible_Installation.sh"]
}
}