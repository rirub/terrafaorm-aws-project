output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet
}

output "private_subnet" {
  value = aws_subnet.private_subnet
}

output "public_SG" {
  value = aws_security_group.public_SG
}

output "private_SG" {
  value = aws_security_group.private_SG
}