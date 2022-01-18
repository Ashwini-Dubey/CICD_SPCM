########################################################
# Provisioning Bastion Host Instance in Public Subnet. #
########################################################
resource "aws_instance" "bastion_host" {
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = "project_key"
  vpc_security_group_ids = [aws_security_group.sg_bastion_host.id]
  subnet_id = "${element(aws_subnet.public_subnet.*.id,0)}"
  
  tags = {
      Name = "Bastion_Host_Instance"
  }

provisioner "remote-exec" {
      inline = [
          "sudo apt-get update"
      ]
  
        connection {
            user = "ubuntu"
            host = "${self.public_ip}"
            type = "ssh"
            private_key = file("project_key.pem")
        }
  }
}