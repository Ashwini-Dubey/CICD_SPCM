variable "aws_region" {
    description = "Region for AWS Resources"
    type = string
    default = "us-east-1"
}

variable "vpc_cidr_block" {
    description = "CIDR block for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
    description = "CIDR Blocks for Public subnets"
    type = list
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
}

variable "private_subnet_cidr_blocks" {
    description = "CIDR Blocks for Private subnets"
    type = list
    default = [
        "10.0.3.0/24",
        "10.0.4.0/24"
    ]
}

variable "azs" {
    description = "Availability Zones for Subnets"
    type = list(string)
    default = [
        "us-east-1a",
        "us-east-1b"
    ]
}

variable "subnet_count" {
    default = 2
  
}