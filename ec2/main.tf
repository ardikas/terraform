provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "myec2" {
    ami = "ami-0911e88fb4687e06b"
    instance_type = "t2.micro"
    tags = {
        Name = "MyFirstTerraformEC2"
    }
}