data "aws_ami" "ubuntu_ec2_ami_ap" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ubuntu_ec2_instance" {
  ami                    = data.aws_ami.ubuntu_ec2_ami_ap.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.Public_Subnet.id
  count                  = 1
  key_name               = "test-server"
  vpc_security_group_ids = [aws_security_group.Main_SG.id]
  # associate_public_ip_address = true Use this if map_public_ip_on_launch = true is not set to the public subnet.
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
  }
  tags = merge(local.common_tags, {
    Name = var.ec2_instance
  })
}

output "instance-info" {
  value = aws_instance.ubuntu_ec2_instance[*].public_ip

}