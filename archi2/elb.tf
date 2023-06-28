resource "aws_lb" "external_lb" {
  name               = "key-external-lb"
  internal           = false            # 내부 또는 외부 로드 밸런서로 변경할 경우 수정해주세요.
  load_balancer_type = "application"    # 로드 밸런서 유형을 변경할 경우 수정해주세요.
  security_groups    = [aws_security_group.public_SG.id]
  subnets = aws_subnet.public_subnets[*].id 

  tags = {
    Name = "${var.tags}-external-alb"
  }
}


resource "aws_lb_target_group" "external_target_group" {
  name     = "key-elb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  target_type = "instance"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "external_tg-attachment" {
    count = 2 
    target_group_arn = aws_lb_target_group.external_target_group.arn
    target_id = aws_instance.web_instance[count.index].id
    port = 80
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.external_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.external_target_group.arn
    type             = "forward"
  }
}


