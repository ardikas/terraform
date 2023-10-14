variable "server_names" {
    type = list(string)
}

resource "aws_instance" "mydbserver" {
    ami = "ami-0911e88fb4687e06b"
    instance_type = "t2.micro"

    count = length(var.server_names)
    tags = {
        Name = var.server_names[count.index]
    }

}

# Instance Id output
output "DbServer_InstanceId" {
    value = [aws_instance.mydbserver.*.id]    
}

# Private IP output
output "PrivateIP_DBserver" {
    value = [aws_instance.mydbserver.*.private_ip]   
}

