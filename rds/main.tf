provider "aws" {
    region = "us-east-2"
}

resource "aws_db_instance" "myRds" {
    db_name = "myDB" 
    identifier = "my-first-rds" # unique name/FQDN of the db server
    instance_class = "db.t2.micro"
    engine = "mariadb"
    engine_version = "10.6.14"
    username = "admin"
    password = "password123" # not good practice. Ideally you should use things like secret injection
    port = 3306 # default db port
    allocated_storage = 20 # this is in GiB. The minimum is 20GiB
    skip_final_snapshot = true # Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value 
}
