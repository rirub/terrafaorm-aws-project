output "public_subnets_id" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnets[*].id
}

output "public_SG" {
  value = aws_security_group.public_SG
}

output "private_SG" {
  value = aws_security_group.private_SG
}

# output "ec2_instance" {
#   value = aws_instance.instance[*].id
# }
