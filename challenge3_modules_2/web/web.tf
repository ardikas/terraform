resource "aws_instance" "mywebserver" {
    ami = "ami-0911e88fb4687e06b"
    instance_type = "t2.micro"
    tags = {
        Name = "Webserver"
    }

    vpc_security_group_ids = [module.WebTrafficSecurityGroupModule.sg_id]

    # The script file for setting up Apache websever via user_data
    user_data = file("./web/server-script.sh")
}

# Security Group Module
module "WebTrafficSecurityGroupModule" {
    source = "../sg"
}

module "eipModule" {
    source = "../eip"

    # the EIP uses the instance ID from the line below (there is a variable for the instance_id in the eip file)
    instance_id = aws_instance.mywebserver.id
}


output "webserver_instanceID" {
    value = aws_instance.mywebserver.id
}

output "eipModule_output" {
    value = module.eipModule.Webserver_eip
}
