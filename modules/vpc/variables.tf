variable "env" {     
  description = "description"
    type        = string
}

variable "vpc_cidr" {
 description = "description"
    type        = string
}

variable "public_subnets" {
 description = "description"
    type        = list(string)
}

variable "private_subnets" {
 description = "description"
    type        = list(string)
}

variable "azs" {
 description = "description"
    type        = list(string)
}

variable "tags" {
 description = "description"
    type        = map(string)
    default = {}
}

