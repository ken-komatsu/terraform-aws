variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "test-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "test-vpc"
   }
}

resource "aws_instance" "example" {
  ami           = "ami-0c3fd0f5d33134a76"
  instance_type = "t3.micro"

  tags = {
    Name = "example"
  }
}
