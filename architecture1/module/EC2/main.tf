module "myvpc" {
  source = "../vpc"
}



resource "aws_key_pair" "ec2_key" {
	key_name = "ey_key"
    public_key = file("./ey_key.pub")
}


resource "aws_instance" "instance" {
  
  for_each = module.myvpc.public_subnet
  ami                         = "ami-0e05f79e46019bfac"
  instance_type               = "t2.micro"
#   subnet_id                   = [module.myvpc.public_subnet.id]
  subnet_id = each.value.id
  key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = "true"
  vpc_security_group_ids = [
    module.myvpc.public_SG.id
  ]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    tags = {
      "Name" = "test-private-ec2-01-vloume-1"
    }
  }

  tags = {
    "Name" = "${var.tags}-${var.region}-ec2"
  }
}
