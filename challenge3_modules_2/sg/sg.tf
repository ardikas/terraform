# Variables for dyanmic blocks for SG
variable "ingressrules" {
    type = list(number)
    default = [80,443,22]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}


# This is the SG for the Web server, using dyanmic block
# This uses the variables that we set above
resource "aws_security_group" "webtraffic" {
    #name = "Allow HTTPS for Web Server"
    description = "Security group for webserver wit HTTP/HTTPS ports open"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }

    }

    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

output "sg_id" {
    value = aws_security_group.webtraffic.id
}
