variable "access_key" {}
variable "secret_key" {}

# definition provider
provider "aws" {
  version = "~> 2.0"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "ap-northeast-1"
}

resouce "aws_vpc" "test-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "test-vpc"
   }
}
