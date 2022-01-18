#Output for VPC ID
output "vpc_id" {
  description = "value"
  value = aws_vpc.vpc.id
}

#Output for Security Group : Bastion Host SG
output "sg_id_bastion_host" {
    description = "ID for Bastion Host SG"
    value = aws_security_group.sg_bastion_host.id
}

#Output for Security Group : Private Access SG
output "sg_id_private_access" {
    description = "ID for Private Access SG"
    value = aws_security_group.private_access.id
}

#Output for Security Group : Public Web SG
output "sg_id_public_web" {
    description = "ID for Public Web SG"
    value = aws_security_group.public_web.id
}

#Output for Pulic IP of Bastion Host
output "public_ip_bastion_host" {
    description = "Public IP for Bastion Host"
    value = aws_instance.bastion_host.public_ip
}

#Output for Private IP of App Host
output "private_ip_app_host" {
    description = "Private IP for App Host"
    value = aws_instance.app_host.private_ip
}

#Output for Private IP of Jenkins Host
output "private_ip_jenkins_host" {
    description = "Private IP for Jenkins Host"
    value = aws_instance.jenkins_host.private_ip
}

#Output for Private IP of Jenkins Host
output "internet_gateway_igw" {
    description = "IGW"
    value = aws_internet_gateway.internet_gateway.id
}
