
# resource "aws_ec2_transit_gateway" "transit_gateway" {
#   description = "Example Transit Gateway"
# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "attachment1" {
#   transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
#   vpc_id             = aws_vpc.vpc1.id
# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "attachment2" {
#   transit_gateway_id = aws_ec2_transit_gateway.example_transit_gateway.id
#   vpc_id             = aws_vpc.vpc2.id
# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "attachment3" {
#   transit_gateway_id = aws_ec2_transit_gateway.example_transit_gateway.id
#   vpc_id             = aws_vpc.vpc3.id
# }
