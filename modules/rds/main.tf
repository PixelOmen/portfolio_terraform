resource "aws_db_subnet_group" "main_db_subnet_group" {
  name       = "${var.prefix}-db-subnet-group-${var.environment}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.prefix}-db-subnet-group-${var.environment}"
    environment = var.environment
  }
}

resource "aws_db_instance" "main_db_instance" {
  apply_immediately       = true
  multi_az                = false
  skip_final_snapshot     = true
  publicly_accessible     = false
  backup_retention_period = 7

  identifier            = "${var.prefix}-rds-postgres-${var.environment}"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"
  engine                = "postgres"
  engine_version        = "16.3"
  instance_class        = "db.t4g.micro"
  username              = var.rds_username
  password              = var.rds_password
  db_name               = var.rds_db_name
  db_subnet_group_name  = aws_db_subnet_group.main_db_subnet_group.name

  tags = {
    Name        = "${var.prefix}-rds-postgres-${var.environment}"
    environment = var.environment
  }
}
