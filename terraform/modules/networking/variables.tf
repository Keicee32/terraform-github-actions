
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_region" {
  description = "The region where the VPC will be created"
  type        = string
}

variable "vpc_name" {}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = list(string)
}

variable "vpc_az" {
  description = "The availability zone for the subnet"
  type        = list(string)
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}

variable "route_cidr_block" {
  description = "Defaults to anywhere"
  default = "0.0.0.0/0"
}