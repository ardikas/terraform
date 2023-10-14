provider "aws" {
    region = "us-east-2"
}

variable "number_of_servers" {
    type = number
}

resource "aws_instance" "ec2" {
    ami = "ami-0d406e26e5ad4de53"
    instance_type = "t2.micro"
    count = var.number_of_servers
}