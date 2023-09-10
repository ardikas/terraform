provider "aws" {
    region = "us-east-2"
}

# References the Db and Web modules
module "DBserver" {
    source = "./db"
}

module "Webserver" {
    source = "./web"
}

######## OUTPUTS FROM MODULES
# DBSERVER PRIVATE IP AND INSTANCE ID
output "DBSever_instanceId" {
    value = module.DBserver.DbServer_InstanceId
}

output "DBServer_privateIp" {
    value = module.DBserver.PrivateIP_DBserver
}

# WEBSERVER EIP AND INSTANCE ID
output "WebServer_instanceId" {
    value = module.Webserver.webserver_instanceID
}

output "WebServer_publicIp" {
    value = module.Webserver.eipModule_output
}


