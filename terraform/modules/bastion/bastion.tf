resource "aws_instance" "bastion" {
  ami           = var.ami   # valid AMI required
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]
  associate_public_ip_address = true


  root_block_device {
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
  }


  tags = {
    Name        = "${var.environment}-bastion-instance"
    Environment = var.environment
  }
}
