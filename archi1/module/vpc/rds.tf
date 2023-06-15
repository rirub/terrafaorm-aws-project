resource "aws_db_subnet_group" "key_db_subnet_group" {
  name       = "key_db_subnet_group-${var.networking.vpc_name}"
  subnet_ids = aws_subnet.private_subnets[*].id
  tags = {
    Name = "example-db-subnet-group"
  }
}


resource "aws_db_instance" "key_db_instance" {
  skip_final_snapshot         = true
  # final_snapshot_identifier   = "example-final-snapshot"
  identifier                = "key-db-instance-${var.networking.vpc_name}"
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  username                  = "admin"
  password                  = "password"
  publicly_accessible       = false
  db_subnet_group_name      = aws_db_subnet_group.key_db_subnet_group.id
  vpc_security_group_ids    = [aws_security_group.private_SG.id]
  # availability_zone         = "ap-northeast-2a"
  multi_az                  = true
  tags = {
    Name = "${var.tags}-${var.networking.vpc_name}-rds"
  }
}