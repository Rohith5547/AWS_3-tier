
resource "aws_db_subnet_group" "db" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
  Name        = "${var.environment}-db-subnet-group"
  Environment = var.environment
}

}
data "aws_secretsmanager_secret" "db-pass" {
  name = "db-password"
}

data "aws_secretsmanager_secret_version" "db_password_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db-pass.id
}

resource "aws_db_instance" "db" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  storage_type         = "gp3"
  publicly_accessible = false
  backup_retention_period = 14
  username             = "foo"
  password             = data.aws_secretsmanager_secret_version.db_password_secret_version.secret_string
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = var.environment != "prod"
  db_subnet_group_name = aws_db_subnet_group.db.name
  vpc_security_group_ids = [var.db_sg_ids]
  max_allocated_storage = 50
  multi_az              = true
}


