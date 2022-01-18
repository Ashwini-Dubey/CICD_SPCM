#############################################################
# Provisioning the AWS VPC , with the CIDR Block 10.0.0.0/16#
#############################################################
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "Course-Project-VPC"
  }
  enable_dns_hostnames = true 
}