# We need to create a variable for the instance ID which the EIP will be assigned to:
variable "instance_id" {
    type = string
}

# This is the EIP for the Web server, and this is how you attach it to a instance which is a variable at this point
resource "aws_eip" "Webserver_elasticip" {
    instance = var.instance_id
}

# This will output the EIP of the web server
output "Webserver_eip" {
    value = aws_eip.Webserver_elasticip.public_ip
}
