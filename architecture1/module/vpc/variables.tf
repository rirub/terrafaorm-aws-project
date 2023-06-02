variable "tags" {
  type        = string
  default     = "cc3-aws1"
}

variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "cidr_block" {
  description = "VPC CIDR BLOCK : x.x.x.x/x"
  type = string
  default = "10.0.0.0/16"
  
}


variable "public_subnet" {
  type = map(any)
  default = {
    pub-sub-2a = {
      az     = "ap-northeast-2a"
      cidr   = "10.0.1.0/24"
    #   des    = "2a"
    #   pri_rt = "pub-sub-2a"
    }
    pub-sub-2c = {
      az     = "ap-northeast-2c"
      cidr   = "10.0.2.0/24"
    #   des    = "2c"
    #   pri_rt = "pub-sub-2c"
    }
  }
}


variable "private_subnet" {
  type = map(any)
  default = {
    pri-sub-2a = {
      az     = "ap-northeast-2a"
      cidr   = "10.0.3.0/24"
    #   des    = "2a"
    #   pri_rt = "pub-sub-2a"
    }
    pri-sub-2c = {
      az     = "ap-northeast-2c"
      cidr   = "10.0.4.0/24"
    #   des    = "2c"
    #   pri_rt = "pub-sub-2c"
    }
  }
}





# variable "private_subnet_cidr" {
#   description = "PRIVATE_SUBNET CIDR BLOCK : x.x.x.x/x"
#   type = string
# }

# variable "public_subnet_az" {}