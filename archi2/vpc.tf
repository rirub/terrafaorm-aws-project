resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc.cidr_block
  tags = {
    Name = "${var.vpc.vpc_name}"
  }
}

# PUBLIC SUBNETS
resource "aws_subnet" "public_subnets" {
  count                   = length(var.pub_subnet.public_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub_subnet.public_subnets[count.index]
  availability_zone       = var.pub_subnet.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tags}-pub_subnet-${count.index}"
  }
}

# PRIVATE SUBNETS
resource "aws_subnet" "private_web_subnets" {
  count                   = length(var.web_subnet.private_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.web_subnet.private_subnets[count.index]
  availability_zone       = var.web_subnet.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tags}-web_subnet-${count.index}"
  }
}

resource "aws_subnet" "private_was_subnets" {
  count                   = length(var.web_subnet.private_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.was_subnet.private_subnets[count.index]
  availability_zone       = var.was_subnet.azs[count.index]

  tags = {
    Name = "${var.tags}-was_subnet-${count.index}"
  }
}


resource "aws_subnet" "privatewe_db_subnets" {
  count                   = length(var.db_subnet.private_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.db_subnet.private_subnets[count.index]
  availability_zone       = var.db_subnet.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tags}-db_subnet-${count.index}"
  }
}

