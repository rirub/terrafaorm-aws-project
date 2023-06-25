resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "key_db_subnet_group"
  subnet_ids = aws_subnet.privatewe_db_subnets[*].id
  tags = {
    Name = "example-db-subnet-group"
  }
}


resource "aws_db_instance" "db_instance" {
  skip_final_snapshot         = true
  # final_snapshot_identifier   = "example-final-snapshot"
  identifier                = "key-db-instance"
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  username                  = "admin"
  password                  = "password"
  publicly_accessible       = false
  db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids    = [aws_security_group.db_sg.id]
  availability_zone         = "ap-northeast-2a"
  tags = {
    Name = "${var.tags}-db-instance"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "web-sg"
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
    Name = "${var.tags}-pri-sg"
  }
}