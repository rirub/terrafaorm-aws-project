
resource "aws_instance" "web_instance" {
  count = length(var.web_subnet.private_subnets)
  ami           = "ami-0e05f79e46019bfac"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_web_subnets[count.index].id
  #   key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = "false"
  vpc_security_group_ids      = [aws_security_group.web_SG.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "${var.tags}-was_instance-${count.index}"
  }

}


resource "aws_security_group" "web_SG" {
  name        = "was-sg"
  description = "Allow all HTTP, ssh"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "For http port"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
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
    Name = "${var.tags}-web-sg"
  }
}


