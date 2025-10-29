
output "vpc_id" {
    description = "The ID of the VPC"
    value       = aws_vpc.app_vpc.id
}

output "subnet_id" {
    description = "The ID of the Subnet"
    value       = aws_subnet.public_app_vpc_subnet[*].id
}

output "private_subnet_id" {
    description = "The ID of the Private Subnet"
    value       = aws_subnet.private_app_vpc_subnet[*].id
}

output "public_subnet_id" {
    description = "The ID of the Public Subnet"
    value       = aws_subnet.public_app_vpc_subnet[*].id
}

output "internet_gateway_id" {
    description = "The ID of the Internet Gateway"
    value       = aws_internet_gateway.app_vpc_igw.id
}

output "route_table_id" {
    description = "The ID of the Route Table"
    value       = aws_route_table.public_app_vpc_rt.id
}