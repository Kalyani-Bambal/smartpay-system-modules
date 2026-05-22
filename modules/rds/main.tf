resource "aws_db_subnet_group" "this" {

  name       = "${var.db_identifier}-subnet-group"

  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.db_identifier}-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {

  name        = "${var.db_identifier}-sg"

  description = "RDS Security Group"

  vpc_id = var.vpc_id

  # Existing CIDR-based access
  ingress {

    from_port = var.db_port

    to_port = var.db_port

    protocol = "tcp"

    cidr_blocks = var.allowed_cidr_blocks

    security_groups = var.allowed_security_groups

  }

  # Bastion Host Access
  ingress {

    description = "MySQL from Bastion"

    from_port = 3306

    to_port = 3306

    protocol = "tcp"

    security_groups = var.allowed_security_groups
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.db_identifier}-sg"
  }
}

resource "aws_db_instance" "this" {

  identifier = var.db_identifier

  engine = var.engine

  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage = var.allocated_storage

  db_name = var.db_name

  username = var.username

  password = var.password

  port = var.db_port

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false

  skip_final_snapshot = true

  multi_az = var.multi_az

  storage_encrypted = true

  backup_retention_period = 0

  tags = {
    Name = var.db_identifier
  }
}