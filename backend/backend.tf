# These tells terraform that we want to make a configuration change
terraform {
    backend "s3" {
        
        # this is the folder path of where you want to save the state file
        # below, you are saving the object file as tfstate.tfstate in the terraform folder, within the bucket
        key = "terraform/tfstate.tfstate"
        bucket = "deeks-terraform-remote-backend-2023"
        region = "us-east-2"

        # You can have the access keys hardcoded here, but if you leave it blank it will act like input prompts
        # for safety purposes, we will leave out the access keys.
        access_key = ""
        secret_key = ""
    }
}