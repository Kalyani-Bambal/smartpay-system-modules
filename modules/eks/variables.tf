variable "env" {
  type        = string
}

variable "cluster_name" {
  type        = string
}

variable "cluster_version" {
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "node_instance_types" {
  type        = list(string)
}

variable "desired_size" {
  type        = number
}

variable "max_size" {
  type        = number
}

variable "min_size" {
  type        = number
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the EKS cluster endpoint."
  type        = list(string)
  default     = []
}

# variable "bastion_access_role_arn" {
#   description = "Bastion IAM role ARN"
#   type        = string
# }

# variable "cluster_role_arn" {
#     description = "EKS Cluster IAM role ARN"
#     type        = string
# }