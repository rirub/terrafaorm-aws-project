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

 resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tags}-${var.region}-igw"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
      # 이 라우트 룰이 igw로 나가게된는 의미
      # 0.0.0.0/0 : 외부 아웃바운드
    }
  tags = {
    Name = "${var.tags}-${var.region}-rt-pub"
  }
}

resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.tags}-${var.region}-private"
  }
}


resource "aws_route_table_association" "public_subnet_association" {
  for_each        = aws_subnet.public_subnet
  subnet_id       = each.value.id
  route_table_id  = aws_route_table.pub_rt.id
}


resource "aws_route_table_association" "private_subnet_association" {
  for_each        = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pri_rt.id
}

