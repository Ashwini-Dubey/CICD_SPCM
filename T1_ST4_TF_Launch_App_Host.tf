##########################################################################################################
# Provisioning App Host Instance in Private Subnet , with attached IAM Role & Installation of AWS CLI#
##########################################################################################################
resource "aws_instance" "app_host" {
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name = "project_key"
  vpc_security_group_ids = [aws_security_group.private_access.id]
  iam_instance_profile = "${aws_iam_instance_profile.course_profile.name}"
  subnet_id = "${element(aws_subnet.private_subnet.*.id,0)}"
  tags = {
      Name = "App_Host_Instance"
  }

provisioner "remote-exec" {
      inline = [
          "sudo apt-get update",
          "curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip",
          "sudo apt-get install unzip",
          "sudo apt-get update",
          "unzip awscliv2.zip",
          "sudo ./aws/install"
      ]
  
        connection {
            user = "ubuntu"
            host = "${self.private_ip}"
            type = "ssh"
            private_key = file("project_key.pem")

            bastion_host = aws_instance.bastion_host.public_ip
            bastion_user = "ubuntu"
            
            bastion_private_key = file("project_key.pem")

        }
  }

}
 
