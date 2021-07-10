provider "aws" {
    access_key = "AKIAZZSJDLM6KXLTF4XS" 
    secret_key = "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"
    region = "ap-northeast-1"
}

resource "aws_vpc" "test-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "test-vpc"
   }
}
