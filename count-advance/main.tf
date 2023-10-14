provider "aws" {
    region = "us-east-2"
}

module "db" {
    source = "./db"

    # Since the variable in db.tf is a list, this is a list
    server_names = ["mariadb","mysql","mssql"]
}

output "instance_ids" {
    value = module.db.DbServer_InstanceId
}

output "private_ips" {
    value = module.db.PrivateIP_DBserver
}