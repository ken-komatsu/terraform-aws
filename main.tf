# definition provider
provider "aws" {
  region = "ap-northeast-1"
  access_key = "AKIAZZSJDLM6PCICUTAS"
  secret_key = "KnBhY/FDP1pVC+gqiY8SUIEGSndsh6R+eNtrR3Rg"
}

resource "aws_vpc" "test-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "test-vpc"
   }
}
