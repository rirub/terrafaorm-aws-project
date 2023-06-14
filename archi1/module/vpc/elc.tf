resource "aws_security_group" "cache" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 11211  # Memcached 포트
    to_port     = 11211
    protocol    = "tcp"
    # cidr_blocks = ["10.0.0.0/16"]  # VPC 내부 트래픽 허용
    cidr_blocks = [var.networking.cidr_block]
  }
}

# resource "aws_subnet_group" "cache" {
#   name        = "key-cache-subnet-group"
#   subnet_ids  = [aws_subnet.private_subnets.id]
#   description = "Example subnet group for Elasticache"
# }

resource "aws_elasticache_subnet_group" "cache" {
  name       = "key-cache-subnet-group"
  subnet_ids = aws_subnet.private_subnets[*].id
}

resource "aws_elasticache_cluster" "example" {
  cluster_id           = "key-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"  # 원하는 노드 유형으로 변경하세요.
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.cache.name
  security_group_ids   = [aws_security_group.cache.id]
}
