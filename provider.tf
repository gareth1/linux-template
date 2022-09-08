terraform {
  required_version = ">=0.12"
backednbackend "s3" {
  bucket    = "s3_bucket_name"
  key       = "states/tableauterraform/terraform.tfstate"
  region    =  "region for deployment"
  role_arn  = "arn for aws IAM role"
    }
}

provider "aws" {
  region = var.region 
}