# Example tfvars for linux-template
region       = "us-west-2"
key_name     = "your_ssh_key_name"
ami          = "ami-0123456789abcdef0" # replace with a real AMI for your region
instance_type = "t3.micro"
instance_count = 1

# Optionally provide groups and ports
# groups = [ { name = "example" , id = "sg-12345678" } ]
# tcp_ports = [22, 80]
# udp_ports = []
