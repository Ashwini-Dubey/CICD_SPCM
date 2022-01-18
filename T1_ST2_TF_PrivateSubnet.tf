###############################################################################
# Create a VPC Private Subnet Resource in the "us-east-1a" & "us-east-1b" AZs #
###############################################################################
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(var.private_subnet_cidr_blocks)}"
  cidr_block              = "${element(var.private_subnet_cidr_blocks, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}" 
  tags = {

    Name = "Course-Project-Private-Subnet"
  }
}