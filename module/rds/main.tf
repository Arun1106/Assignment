resource "aws_db_instance" "example" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = var.sg_id
  skip_final_snapshot    = true
  tags = {
    Name = var.name
  }
}

resource "aws_db_subnet_group" "default" {
  name       = var.identifier
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.identifier
  }
}