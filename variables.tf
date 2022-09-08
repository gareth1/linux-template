variable "region" {
  description = "which AWS region to place instance in"
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "the name of the vpc these resources  are placeed into. Used by a data source to lookup VPC ID's"
  default     = "vpc_value"
}

variable "subnet_tier" {
  description = "internal or external"
  default     = "internal"
}

data "aws_subnet_ids" "name_of_subnets" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name = "tag:tier"
    values = ["${var.subnet_tier}"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name = "tag:name"
    values = ["{var.vpc_name}"]
  }
}

data "aws_security_group" "all" {
  vpc_id = data.aws_vpc.vpc.id 
  filter {
    name = "tag:name"
    values = ["all"]
  }
}

variable "key_name" {
  description = "SSH key to be used to create instance with"
  default = "name_ssh_key"
}