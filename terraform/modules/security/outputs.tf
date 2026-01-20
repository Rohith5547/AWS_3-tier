output "bastion_sg_id" {
    value = aws_security_group.bastionSg.id
}

output "alg_sg_id" {
    value = aws_security_group.alg_sg.id
}