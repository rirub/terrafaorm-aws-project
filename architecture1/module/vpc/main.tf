resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.tags}-${var.region}-vpc"
  }
}


resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnet
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tags}-${var.region}-${each.key}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each                = var.private_subnet
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tags}-${var.region}-${each.key}"
  }
}

#  resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "${var.tags}-igw"
#   }
# }