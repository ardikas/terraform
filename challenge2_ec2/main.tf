# This terraform code will spin up:
# 1. Create a DB Server and output the private IP (EC2 instance called “DBserver”) (done)
# 2. Create a web server and ensure it has a fixed public IP (done)
# 3. Create a Security Group for the web server opening ports 80 and 443 (HTTP and HTTPS)
# 4. Run user-data script to start up Apache

provider "aws" {
    region = "us-east-2"
}

# These variables sets up the SG rules using dynamic block
variable "ingressrules" {
    type = list(number)
    default = [80,443,22]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}

# Spins up a DB server. Will have private IP
resource "aws_instance" "DBserver" {
    ami = "ami-0911e88fb4687e06b"
    instance_type = "t2.micro"
    tags = {
        Name = "DBserver"
    }
}

# Spins up the Web server with fixed public IP. 
resource "aws_instance" "Webserver" {
    ami = "ami-0911e88fb4687e06b"
    instance_type = "t2.micro"
    tags = {
        Name = "Webserver"
    }

    security_groups = [aws_security_group.webtraffic.name]

    # The script file for setting up Apache websever via user_data
    user_data = file("server-script.sh")
}

# This is the SG for the Web server, using dyanmic block
# This uses the variables that we set above
resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

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

# This is the EIP for the Web server
resource "aws_eip" "Webserver_elasticip" {
    instance = aws_instance.Webserver.id 
}

# This will output the private Ip of the DB server
output "PrivateIP_DBserver" {
    value = aws_instance.DBserver.private_ip    
}

# This will output the EIP of the web server
output "EIP_Webserver" {
    value = aws_eip.Webserver_elasticip.public_ip
}
