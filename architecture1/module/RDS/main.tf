# module "myvpc" {
#   source = "../vpc"
# }


# resource "aws_db_subnet_group" "rdsSubnetGroup" {
#   for_each = module.myvpc.private_subnet
#   subnet_ids = [each.value.id]
#   name = "rds-ey"
#   availability_zones        = ["ap-northeast-2a","ap-northeast-2c"]
#   # subnet_ids = [module.myvpc.public_subnet.id]
#   tags = {
#     Name = "${var.tags}-${var.region}-rds-subnetgroup"
#   }
# }


# resource "aws_db_instance" "example" {
#   identifier             = "mydbinstance"  # 원하는 인스턴스 식별자로 변경해주세요.
#   engine                 = "mysql"        # 데이터베이스 엔진을 변경할 경우 수정해주세요.
#   instance_class         = "db.t2.micro"  # 인스턴스 유형을 변경할 경우 수정해주세요.
#   allocated_storage      = 20             # 할당된 스토리지 용량 (GB)을 변경할 경우 수정해주세요.
#   name                   = "mydatabase"   # 데이터베이스 이름을 원하는 이름으로 변경해주세요.
#   username               = "admin"        # 데이터베이스 사용자 이름을 원하는 이름으로 변경해주세요.
#   password               = "password123"  # 데이터베이스 사용자 비밀번호를 원하는 비밀번호로 변경해주세요.
#   parameter_group_name   = "default.mysql5.7"  # 데이터베이스 파라미터 그룹을 변경할 경우 수정해주세요.
#   publicly_accessible   = false           # RDS에 대한 공개 액세스를 허용하지 않으려면 false로 설정합니다.

#   # 보안 그룹 설정
#   vpc_security_group_ids = ["sg-0123456789abcdef"]  # 원하는 보안 그룹 ID로 변경해주세요.

#   # VPC 및 서브넷 설정
#   vpc_security_group_ids = ["sg-0123456789abcdef"]  # 원하는 보안 그룹 ID로 변경해주세요.
#   subnet_group_name      = "my-db-subnet-group"  # 생성한 VPC 서브넷 그룹의 이름으로 변경해주세요.
#   subnet_ids             = [aws_subnet.private.id]  # private 서브넷 ID로 변경해주세요.
# }
