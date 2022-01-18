########################################################################################
# Provisioning the Route Table for Internet Gateway & associating it with Public Subnet#
########################################################################################
resource "aws_route_table" "IG_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
      Name = "Course-Project-IG-route-table"
  }
}

#Associating IG-route-table to public-subnet
resource "aws_route_table_association" "associate_igw_route_table_public_subnet" {

    count = var.subnet_count
    subnet_id = "${element(aws_subnet.public_subnet.*.id,count.index)}"
    route_table_id = aws_route_table.IG_route_table.id
}

