
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18.0"
    }
  }
}

provider "aws" {
  profile = "dufuna"
  region  = "eu-west-1"
}


module "vpc" {
  source                    = "./networking"
  cidr_block                = "192.188.0.0/16"
  vpc_region                = "eu-west-1"
  vpc_name                  = "app-vpc"
  public_subnet_cidr_block  = ["192.188.1.0/24", "192.188.3.0/24"]
  private_subnet_cidr_block = ["192.188.2.0/24", "192.188.4.0/24"]
  vpc_az                    = ["eu-west-1a", "eu-west-1b"]
  route_cidr_block          = "0.0.0.0/0"
}