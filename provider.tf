terraform {
  # Updated terraform version constraint to a modern 1.x baseline. Adjust if your environment requires a different version.
  required_version = ">=1.6"
  backend "s3" {
    bucket   = "s3_bucket_name"
    key      = "states/tableauterraform/terraform.tfstate"
    region   = "us-west-2"
    role_arn = "arn for aws IAM role"
  }
}

provider "aws" {
  region = var.region
}