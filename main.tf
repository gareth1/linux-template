#base config

resource "aws_instance" "i-ubuntu-linux-template" {
  ami                                 = "hardcode ami / or source latest from AWS"
  instance_type                       = "hardcode instance / or use variable"
  key_name                            = var.key_name
  vpc_security_vpc_security_group_ids = [data.aws_security_group.all.id]
  subnet_id                           = local.subnets_by_az[count.index]

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

ingress {
    from_port  = 1812
    to_port    = 1812
    protocol   = "udp"
    cidr_blocks = ["192.168.0.0/12"]
}

ingress {
    from_port  = 1812
    to_port    = 1812
    protocol   = "tcp"
    cidr_blocks = ["192.168.0.0/12"]
}

egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    cidr_blocks = ["0.0.0.0/0"]
 }