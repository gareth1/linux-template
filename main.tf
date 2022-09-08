#base config

resource "aws_instance" "i-ubuntu-linux-template" {
  ami                                 = "hardcode ami / or source latest from AWS"
  instance_type                       = "hardcode instance / or use variable"
  key_name                            = var.key_name
  vpc_security_vpc_security_group_ids = [data.aws_security_group.template.id]
  subnet_id                           = local.subnets_by_az[count.index]
  associate_public_ip_address         = "true" 

  root_block_root_block_device {
    volume_size = "60"
    volume_type = "standard"
    delete_on_termination = "false"
  } 

  tags = {
    "name" = "i-ubuntu-linux-template"
  }

}

#client access 

resource "aws_security_group" "template" {
  for_each = { for g in var.groups : g.name => g }

  name = "test2-${each.key}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.tcp_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = var.groups[*].id
    }
  }

  dynamic "ingress" {
    for_each = var.udp_ports
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "udp"
      security_groups = var.groups[*].id
    }
  }
}