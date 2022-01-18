#######################################################################################################
# Terraform Provisoiner , to download the required provider block and initialize the Working Directory#
#######################################################################################################
terraform {
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}