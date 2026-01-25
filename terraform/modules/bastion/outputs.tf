output "keyname" {
    value = var.key_name
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_sg_id" {
  value = aws_security_group.bastionSg.id
}