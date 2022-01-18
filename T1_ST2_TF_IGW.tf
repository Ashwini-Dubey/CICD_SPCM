######################################################
# Provisioning the AWS NAT Gateway in Public Subnet. #
######################################################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
      Name = "Course-Project-IGW"
  }
}