# variable "tags" {
#   type    = string
#   default="key"
# }

# variable "region" {
#   type    = string
#   default = "ap-northeast-2"
# }

# variable "networking" {
#   type = object({
#     cidr_block      = string
#     region          = string
#     vpc_name        = string
#     azs             = list(string)
#     public_subnets  = list(string)
#     private_subnets = list(string)
#   })
#   default = {
#     cidr_block      = "10.0.0.0/16"
#     region          = "ap-northeast-2"
#     vpc_name        = "custom-vpc"
#     azs             = ["ap-northeast-2a", "ap-northeast-2c"]
#     public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
#     private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
#   }
#  }

