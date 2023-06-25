variable "tags" {
    default="key"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "vpc" {
  type = object({
    cidr_block      = string
    vpc_name        = string
  })

  default = {
  cidr_block      = "10.0.0.0/16"
  vpc_name        =  "key_vpc"
  }
}

variable "pub_subnet" {
  type = object({
    azs             = list(string)
    public_subnets  = list(string)
  })
  default = {
    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  }
}


variable "web_subnet" {
  type = object({
    azs             = list(string)
    private_subnets = list(string)
  })
  default = {
    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  }
}

variable "was_subnet" {
   type = object({
    azs             = list(string)
    private_subnets = list(string)
  })
  default = {
    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnets = ["10.0.4.0/24", "10.0.5.0/24"]
  }
}

variable "db_subnet" {
  type = object({
    azs             = list(string)
    private_subnets = list(string)
  })
  default = {
    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    private_subnets = ["10.0.6.0/24", "10.0.7.0/24"]
  }
}