# Create VPC
resource "aws_vpc" "Dev-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  enable_dns_hostnames = true

  tags = {
    Name = "Dev-VPC"
  }
}

# Create IGW
resource "aws_internet_gateway" "Dev-IGW" {
  vpc_id = aws_vpc.Dev-VPC.id

  tags = {
    Name = "Dev-IGW"
  }
}

# Creating EIP Elastic IP Allocation
resource "aws_eip" "eipalloc-0e6f0e34016b1f905" {
}

# Creating NAT Gateway
resource "aws_nat_gateway" "Dev-NATGW" {
  subnet_id     = aws_subnet.Public_subnet_AZ1.id
  allocation_id = aws_eip.eipalloc-0e6f0e34016b1f905.id
  tags = {
    Name = "Dev-NATGW"
  }
}

# Create Public Subnet AZ1
resource "aws_subnet" "Public_subnet_AZ1" {
  vpc_id                  = aws_vpc.Dev-VPC.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet_AZ1"
  }
}

# Create Public Subnet AZ2
resource "aws_subnet" "Public_subnet_AZ2" {
  vpc_id                  = aws_vpc.Dev-VPC.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet_AZ2"
  }
}

# Create Private App Subnet AZ1
resource "aws_subnet" "Private_App_Subnet_AZ1" {
  vpc_id            = aws_vpc.Dev-VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "Private_App_Subnet_AZ1"
  }
}

# Create Private App Subnet AZ2
resource "aws_subnet" "Private_App_Subnet_AZ2" {
  vpc_id            = aws_vpc.Dev-VPC.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1d"
  tags = {
    Name = "Private_App_Subnet_AZ2"
  }
}

# Create Private Data Subnet AZ1
resource "aws_subnet" "Private_Data_Subnet_AZ1" {
  vpc_id            = aws_vpc.Dev-VPC.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1e"
  tags = {
    Name = "Private_Data_Subnet_AZ1"
  }
}

# Create Private Data Subnet AZ2
resource "aws_subnet" "Private_Data_Subnet_AZ2" {
  vpc_id            = aws_vpc.Dev-VPC.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1f"
  tags = {
    Name = "Private_Data_Subnet_AZ2"
  }
}

# Create Public Route Table
resource "aws_route_table" "Dev_Public_RT" {
  vpc_id = aws_vpc.Dev-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Dev-IGW.id
  }
  tags = {
    Name = "Dev_Public_RT"
  }

}

# Create Route Table Association for Public_subnet_AZ1
resource "aws_route_table_association" "Dev_Public_Route_Ass_AZ1" {
  subnet_id      = aws_subnet.Public_subnet_AZ1.id
  route_table_id = aws_route_table.Dev_Public_RT.id
}

# Create Route Table Association for Public_subnet_AZ2
resource "aws_route_table_association" "Dev_Public_Route_Ass_AZ2" {
  subnet_id      = aws_subnet.Public_subnet_AZ2.id
  route_table_id = aws_route_table.Dev_Public_RT.id
}

# Create Private Route Table
resource "aws_route_table" "Dev_Private_RT" {
  vpc_id = aws_vpc.Dev-VPC.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Dev-NATGW.id
  }

  tags = {
    Name = "Dev_Private_RT"
  }

}

# Create Route Table Association for Dev_Private_App_Subnet_AZ1
resource "aws_route_table_association" "Dev_Private_App_Subnet_RT_Ass1" {
  subnet_id      = aws_subnet.Private_App_Subnet_AZ1.id
  route_table_id = aws_route_table.Dev_Private_RT.id
}

# Create Route Table Association for Dev_Private_App_Subnet_AZ2
resource "aws_route_table_association" "Dev_Private_App_Subnet_RT_Ass2" {
  subnet_id      = aws_subnet.Private_App_Subnet_AZ2.id
  route_table_id = aws_route_table.Dev_Private_RT.id
}

# Create Route Table Association for Dev_Private_Data_Subnet_AZ1
resource "aws_route_table_association" "Dev_Private_Data_Subnet_RT_Ass1" {
  subnet_id      = aws_subnet.Private_Data_Subnet_AZ1.id
  route_table_id = aws_route_table.Dev_Private_RT.id
}

# Create Route Table Association for Dev_Private_Data_Subnet_AZ2
resource "aws_route_table_association" "Dev_Private_Data_Subnet_RT_Ass2" {
  subnet_id      = aws_subnet.Private_Data_Subnet_AZ2.id
  route_table_id = aws_route_table.Dev_Private_RT.id
}

