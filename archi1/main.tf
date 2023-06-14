provider "aws"{
    region = "ap-northeast-2"
}


module "vpc1"{
  source = "./module/vpc"
  region = "ap-northeast-2"
  networking      = var.networking1
  tags = {
    Name = "vpc1"
  }
}

module "vpc2"{
  source = "./module/vpc"
  region = "ap-northeast-2"
  networking      = var.networking2
  tags = {
    Name = "vpc2"
  }
}

module "vpc3"{
  source = "./module/vpc"
  region = "ap-northeast-2"
  networking      = var.networking3
  tags = {
    Name = "vpc3"
  }

}

