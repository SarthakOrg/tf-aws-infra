resource "aws_instance" "app" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  vpc_security_group_ids  = var.security_group_ids
  disable_api_termination = true

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_name
  }
}
