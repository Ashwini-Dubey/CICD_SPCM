######################################################
# Provisioning the AWS NAT Gateway in Public Subnet. #
######################################################
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = "${element(aws_subnet.public_subnet.*.id,0)}"
  tags = {
      Name = "Course-Project-NAT-GW"
  }
}