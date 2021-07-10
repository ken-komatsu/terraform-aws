# definition provider
provider "aws" {
  region = "${var.provider_region}"
  access_key = "${var.access_key}"
  secret_key = Gj/1jiR/hKNRzU9LY0PTZMwfT5vrlQLW3sQlq9Vo
}

resource "aws_vpc" "test-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "test-vpc"
   }
}
