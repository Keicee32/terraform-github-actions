
# ====================== #
#       VPC Setup        #
# ====================== #
resource "aws_vpc" "app_vpc" {
    cidr_block = var.cidr_block
    region = var.vpc_region
    tags = {
        Name = var.vpc_name
    }
}

# ====================== #
#     Subnet Setup       #
# ====================== #

resource "aws_subnet" "public_app_vpc_subnet" {
    count = length(var.public_subnet_cidr_block)

    vpc_id = aws_vpc.app_vpc.id
    region = var.vpc_region
    cidr_block = var.public_subnet_cidr_block[count.index]
    availability_zone = var.vpc_az[count.index]
    tags = {
        Name = "${var.vpc_name}-subnet-${count.index}"
    }

    depends_on = [ aws_vpc.app_vpc ]
}


resource "aws_subnet" "private_app_vpc_subnet" {
    count = length(var.private_subnet_cidr_block)

    vpc_id = aws_vpc.app_vpc.id
    region = var.vpc_region
    cidr_block = var.private_subnet_cidr_block[count.index]
    availability_zone = var.vpc_az[count.index]
    tags = {
        Name = "${var.vpc_name}-subnet-${count.index}"
    }

    depends_on = [ aws_vpc.app_vpc ]
}


# ====================== #
#  Internet Gateway      #  
# ====================== #

resource "aws_internet_gateway" "app_vpc_igw" {
    vpc_id = aws_vpc.app_vpc.id
    region = var.vpc_region
    tags = {
        Name = "${var.vpc_name}-igw"
    }

    depends_on = [ aws_vpc.app_vpc ]
}

# ====================== #
#   Route Table Setup    #
# ====================== #

resource "aws_route_table" "public_app_vpc_rt" {
    vpc_id = aws_vpc.app_vpc.id
    region = var.vpc_region

    route {
        gateway_id = aws_internet_gateway.app_vpc_igw.id
        cidr_block = var.route_cidr_block
    }
    tags = {
        Name = "${var.vpc_name}-public-rt"
    }

    depends_on = [ aws_vpc.app_vpc , aws_internet_gateway.app_vpc_igw , aws_subnet.public_app_vpc_subnet ]
}

resource "aws_route_table_association" "public_app_vpc_rt_assoc" {
    count = length(var.public_subnet_cidr_block)

    subnet_id      = aws_subnet.public_app_vpc_subnet[count.index].id
    route_table_id = aws_route_table.public_app_vpc_rt.id

    depends_on = [ aws_vpc.app_vpc , aws_route_table.public_app_vpc_rt , aws_subnet.public_app_vpc_subnet ]
}