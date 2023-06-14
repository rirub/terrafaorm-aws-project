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
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pub_rt.id
}


resource "aws_route_table_association" "private_subnet_association" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pri_rt.id
}

# 보안그룹
resource "aws_security_group" "public_SG" {
  name        = "public-sg"
  description = "Allow all HTTP"
  vpc_id      = aws_vpc.vpc.id

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
    Name = "${var.tags}-${var.region}-pub-sg"
  }
}

## private Security Group for rds
resource "aws_security_group" "private_SG" {
  name        = "private-sg"
  description = "Allow mysql"
  vpc_id      = aws_vpc.vpc.id

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
    Name = "${var.tags}-${var.region}-pri-sg"
  }
}