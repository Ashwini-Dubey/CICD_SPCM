####################################################################################
# Provisioning the Route Table for NAT Gateway & associating it with Private Subnet#
####################################################################################
resource "aws_route_table" "NAT_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
      Name = "Course-Project-NATGW-Route-Table"
  }
}

#Associating IG-route-table to private-subnet
resource "aws_route_table_association" "associate_nat_route_table_private_subnet" {

    subnet_id = "${element(aws_subnet.private_subnet.*.id,0)}"
    route_table_id = aws_route_table.NAT_route_table.id
  
}