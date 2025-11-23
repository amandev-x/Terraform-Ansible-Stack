resource "aws_security_group" "Main_SG" {
  name        = "terraform-ansible-stack-SG"
  description = "A security group for Terraform and Ansible Stack"
  vpc_id      = aws_vpc.Main_VPC.id
  tags = merge(local.common_tags, {
    Name = "Main-Security-Group"
  })
}

## ➡️ INGRESS (INBOUND) RULES
resource "aws_vpc_security_group_ingress_rule" "ssh_inbound" {
  security_group_id = aws_security_group.Main_SG.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.secure_ip_address_ssh_inbound
  description       = "Allow SSH inbound from known IP address"
  tags = merge(local.common_tags, {
    Name = "ssh-inbound"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http-inbound" {
  security_group_id = aws_security_group.Main_SG.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow inbound HTTP traffic"
  tags = merge(local.common_tags, {
    Name = var.http_inbound
  })
}

resource "aws_vpc_security_group_ingress_rule" "https-inbound" {
  security_group_id = aws_security_group.Main_SG.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow inbound HTTPS traffic"
  tags = merge(local.common_tags, {
    Name = var.https_inbound
  })
}

## ⬅️ EGRESS (OUTBOUND) RULES
resource "aws_vpc_security_group_egress_rule" "http_outbound" {
  security_group_id = aws_security_group.Main_SG.id
  from_port         = 80 # Use 0 for all ports
  to_port           = 80
  ip_protocol       = "tcp" # Use -1 for all protocols
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow outbound HTTP traffic"
  tags = merge(local.common_tags, {
    Name = var.http_outbound
  })
}

resource "aws_vpc_security_group_egress_rule" "https_outbound" {
  security_group_id = aws_security_group.Main_SG.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow outbound HTTPS traffic"
  tags = merge(local.common_tags, {
    Name = var.https_outbound
  })
}
resource "aws_vpc_security_group_egress_rule" "dns_access" {
  security_group_id = aws_security_group.Main_SG.id
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow outbound DNS lookups (UDP 53)"
  tags = merge(local.common_tags, {
    Name = var.dns_outbound
  })
}