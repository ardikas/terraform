provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "web" {
    ami = "ami-0d406e26e5ad4de53"
    instance_type = "t2.micro"

    # this means, terraform will create the db server first and then the web server. 
    depends_on = [aws_instance.db]
}

resource "aws_instance" "db" {
    ami = "ami-0d406e26e5ad4de53"
    instance_type = "t2.micro"
    tags = {
        Name = "DB Server"
    }
}

data "aws_instance" "dbsearch" {
    filter {
        name = "tag:Name"
        values = ["DB Server"]
    }
}

output "dbserver_az" {
    value = data.aws_instance.dbsearch.availability_zone
}