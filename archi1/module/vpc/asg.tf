resource "aws_launch_configuration" "key_lc" {
  name                 = "key-launch-configuration"
  image_id             = "ami-0e05f79e46019bfac"  # AMI ID를 입력하세요.
  instance_type        = "t2.micro"     # 인스턴스 유형을 선택하세요.
  security_groups      = [aws_security_group.public_SG.id]  # 보안 그룹 ID를 입력하세요.

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling 그룹 생성
# resource "aws_autoscaling_group" "key_asg" {
#   name                      = "my-asg"
#   min_size                  = 1
#   max_size                  = 3
#   desired_capacity          = 2
#   vpc_zone_identifier       = [aws_subnet.subnet_id]
#   launch_template {
#     id = aws_launch_template.launch_template.id
#   }
#   tag {
#     key                 = "Name"
#     value               = "key-asg"
#   }
# }

resource "aws_autoscaling_group" "key_asg" {
  name                 = "key-asg"
  launch_configuration = aws_launch_configuration.key_lc.id
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  =  aws_subnet.public_subnets[*].id # Auto Scaling Group을 배포할 서브넷 ID를 입력하세요.

  tag {
    key                 = "Name"
    value               = "key-asg"
    propagate_at_launch = true
  }
}



# resource "aws_autoscaling_attachment" "example_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.key_asg.name
#   instance_id               = aws_instance.instance[*].id
# }

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.key_asg.name
  lb_target_group_arn   = aws_lb_target_group.alb_target_group.arn
}