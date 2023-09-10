resource "aws_instance" "mydbserver" {
    ami = "ami-0911e88fb4687e06b"
    instance_type = "t2.micro"
    tags = {
        Name = "Dbserver"
    }
}

# Instance Id output
output "DbServer_InstanceId" {
    value = aws_instance.mydbserver.id    
}

# Private IP output
output "PrivateIP_DBserver" {
    value = aws_instance.mydbserver.private_ip   
}


