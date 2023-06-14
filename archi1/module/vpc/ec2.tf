# resource "aws_key_pair" "ec2_key" {
# 	key_name = "ey_key_${var.networking.vpc_name}" #var 추가해서 vpc 이름 붙이기
#   public_key = file("C:/Users/강은영/terraform-aws/archi1/module/vpc/ey_key.pub")
# }


# resource "aws_instance" "instance" { 
#   count                   = 2
#   ami                         = "ami-0e05f79e46019bfac"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.public_subnets[count.index].id
#   key_name                    = aws_key_pair.ec2_key.key_name
#   associate_public_ip_address = "true"
#   vpc_security_group_ids = [    aws_security_group.public_SG.id  ]
#   root_block_device {
#     volume_size = 8
#     volume_type = "gp2"
#   }
#   tags = {
#     Name = "${var.tags}-${var.networking.vpc_name}-${count.index}"
#   }
  
# }

