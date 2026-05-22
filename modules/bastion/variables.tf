variable "project" {}

variable "vpc_id" {}

variable "public_subnet_id" {}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}

variable "allowed_ssh_cidr" {
  type = list(string)
}