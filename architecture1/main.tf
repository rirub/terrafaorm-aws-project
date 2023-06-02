provider "aws"{
    region = "ap-northeast-2"
}


module "vpc"{
  source = "./module/vpc"
  cidr_block = var.cidr_block 
  
}

