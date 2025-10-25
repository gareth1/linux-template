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

data "aws_subnets" "name_of_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:tier"
    values = ["${var.subnet_tier}"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:name"
    values = ["${var.vpc_name}"]
  }
}

data "aws_security_group" "all" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:name"
    values = ["all"]
  }
}

variable "key_name" {
  description = "SSH key to be used to create instance with"
  default     = "name_ssh_key"
}

variable "groups" {
  description = "Optional list of security-group objects to reference when creating ingress rules"
  type = list(object({
    name = string
    id   = string
  }))
  default = []
}

variable "tcp_ports" {
  description = "List of TCP ports to allow (used by aws_security_group.dynamic ingress)"
  type = list(number)
  default = []
}

variable "udp_ports" {
  description = "List of UDP ports to allow (used by aws_security_group.dynamic ingress)"
  type = list(number)
  default = []
}


variable "ami" {
  description = "AMI id to use for aws_instance. If empty, set via tfvars or environment"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of instances to create (will be distributed across available subnets)"
  type        = number
  default     = 1
}