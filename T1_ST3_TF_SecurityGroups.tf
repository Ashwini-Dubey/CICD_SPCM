######################################################################################
# Provisioning the AWS Security Group for the Bastion Host , Jenkins Host & App Host.#
######################################################################################
#Security Group for Bastion Host.
resource "aws_security_group" "sg_bastion_host" {
  name = "Bastion Host SG"
  description = "Bastion Host SG"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Course-Project-Bastion-Host-SG"
  }

  ingress {
      description = "Allow Self IP to ssh to bastion instance"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${chomp(data.http.self_ip.body)}/32"]
  }
  egress {
      description = "Allow all egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

#Security Group for EC2 Instances in Private Subnet
resource "aws_security_group" "private_access" {
  name = "Private Host SG"
  description = "Private Instances Security Group"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Course-Project-PrivateHost-SG"
  }

  ingress {
      description = "Allow all incoming traffic from within the VPC"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
      description = "Allow all incoming traffic from within the VPC"
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
      description = "Allow all egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}


#Security Group for EC2 Instances in Public Web.
resource "aws_security_group" "public_web" {
  name = "Public Web SG"
  description = "Public Web SG"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Course-Project-Public-Web-SG"
  }

  ingress {
      description = "Allow all incoming to port 80 from Self IP"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["${chomp(data.http.self_ip.body)}/32"]
  }
  egress {
      description = "Allow all egress"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
