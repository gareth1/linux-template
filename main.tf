#base config

resource "aws_instance" "i-ubuntu-linux-template" {
  ami                                 = var.ami
  instance_type                       = var.instance_type
  count                               = var.instance_count
  key_name                            = var.key_name
  vpc_security_group_ids              = [data.aws_security_group.all.id]
  subnet_id                           = local.subnets_by_az[count.index % length(local.subnets_by_az)]
  associate_public_ip_address         = true

  root_block_device {
    volume_size           = 60
    volume_type           = "standard"
    delete_on_termination = false
  }

  tags = {
    "name" = "i-ubuntu-linux-template-${count.index}"
  }

}

locals {
  # list of subnet ids discovered via data source; used to place instances across AZs
  subnets_by_az = data.aws_subnets.name_of_subnets.ids
}

#client access 

resource "aws_security_group" "template" {
  # create zero or more security groups depending on var.groups
  for_each = { for g in var.groups : g.name => g }

  name   = "test2-${each.key}"
  vpc_id = data.aws_vpc.vpc.id

  # TCP ports from var.tcp_ports (list of numbers)
  dynamic "ingress" {
    for_each = var.tcp_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [for g in var.groups : g.id]
      cidr_blocks     = []
    }
  }

  # UDP ports from var.udp_ports (list of numbers)
  dynamic "ingress" {
    for_each = var.udp_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "udp"
      security_groups = [for g in var.groups : g.id]
      cidr_blocks     = []
    }
  }
}