resource "aws_key_pair" "ec2_key" {
	key_name = "ey_key_archi2" #var 추가해서 vpc 이름 붙이기
    public_key = file("C:/Users/강은영/terraform-aws/archi2/ey_key.pub")
}


resource "aws_instance" "bastion_host" {
  ami           = "ami-0e05f79e46019bfac"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnets[0].id
  #   key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.public_SG.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "${var.tags}-bastion_host"
  }

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnets[0].id
  route_table_id = aws_route_table.public.id
}


resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
}


output "nat_gateway_public_ip" {
  value = aws_eip.eip.public_ip
}

resource "aws_security_group" "public_SG" {
  name        = "public-sg"
  description = "Allow all ssh"
  vpc_id      = aws_vpc.my_vpc.id


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


