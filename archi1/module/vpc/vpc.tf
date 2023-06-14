resource "aws_vpc" "my_vpc" {
  cidr_block = var.networking.cidr_block

  tags = {
    Name = "${var.tags}-${var.networking.region}"
  }
}

# PUBLIC SUBNETS
resource "aws_subnet" "public_subnets" {
  count                   = var.networking.public_subnets == null || var.networking.public_subnets == "" ? 0 : length(var.networking.public_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.networking.public_subnets[count.index]
  availability_zone       = var.networking.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tags}-public_subnet-${count.index}"
  }
}

# PRIVATE SUBNETS
resource "aws_subnet" "private_subnets" {
  count                   = var.networking.private_subnets == null || var.networking.private_subnets == "" ? 0 : length(var.networking.private_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.networking.private_subnets[count.index]
  availability_zone       = var.networking.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tags}-private_subnet-${count.index}"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "i_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.tags}-i_gateway"
  }
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "public_table" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route" "public_routes" {
  route_table_id         = aws_route_table.public_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.i_gateway.id
}

resource "aws_route_table_association" "assoc_public_routes" {
  count          = length(var.networking.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_table.id
}



# 보안그룹
resource "aws_security_group" "public_SG" {
  name        = "public-sg"
  description = "Allow all HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "For http port"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "For http port"
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "For ssh port"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

    tags = {
    Name = "${var.tags}-${var.networking.region}-pub-sg"
  }
}

## private Security Group for rds
resource "aws_security_group" "private_SG" {
  name        = "private-sg"
  description = "Allow mysql"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "For mysql port"
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    Name = "${var.tags}-${var.networking.region}-pri-sg"
  }
}