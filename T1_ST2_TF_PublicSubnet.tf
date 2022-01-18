##############################################################################
# Create a VPC Public Subnet Resource in the "us-east-1a" & "us-east-1b" AZs #
##############################################################################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(var.public_subnet_cidr_blocks)}"
  cidr_block              = "${element(var.public_subnet_cidr_blocks, count.index)}"
  availability_zone       = "${element(var.azs,   count.index)}"
  map_public_ip_on_launch = true
  tags = {

    Name = "Course-Project-Public-Subnet"
  }
}