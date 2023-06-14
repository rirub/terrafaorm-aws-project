provider "aws" {
    profile = "tf-profile"
}

//한국, 도쿄, 버지니아 리전
locals {
    regions = ["ap-northeast-2", "ap-northeast-1", "us-east-1"]
}


output  {
    count=3
    value = local.regions[count.index]
}