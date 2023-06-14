module "myvpc" {
  source = "../vpc"
}


resource "aws_lb" "alb" {
  name               = "my-alb"         # 원하는 ALB 이름으로 변경해주세요.
  internal           = false            # 내부 또는 외부 로드 밸런서로 변경할 경우 수정해주세요.
  load_balancer_type = "application"    # 로드 밸런서 유형을 변경할 경우 수정해주세요.
  security_groups    = [module.myvpc.public_SG.id]
  subnets            = [module.myvpc.public_subnet.id]

  tags = {
    Name = "my-alb"
  }
}