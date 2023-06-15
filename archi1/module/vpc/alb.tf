resource "aws_lb" "alb" {
  name               = "key-alb-${var.networking.vpc_name}"         # 원하는 ALB 이름으로 변경해주세요.
  internal           = false            # 내부 또는 외부 로드 밸런서로 변경할 경우 수정해주세요.
  load_balancer_type = "application"    # 로드 밸런서 유형을 변경할 경우 수정해주세요.
  security_groups    = [aws_security_group.public_SG.id]
  subnets = aws_subnet.public_subnets[*].id 

  tags = {
    Name = "${var.tags}-${var.networking.vpc_name}-alb"
  }
}


resource "aws_lb_target_group" "alb_target_group" {
  name     = "key-target-group-${var.networking.vpc_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    type             = "forward"
  }
}