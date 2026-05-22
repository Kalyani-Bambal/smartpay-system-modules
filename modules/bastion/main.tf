resource "aws_security_group" "bastion_sg" {
  name        = "${var.project}-bastion-sg"
  description = "Security group for Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH Access"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.allowed_ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-bastion-sg"
  }
}

resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type

  subnet_id                   = var.public_subnet_id

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]

  associate_public_ip_address = true

  key_name = var.key_name

  tags = {
    Name = "${var.project}-bastion"
  }
}