variable "cluster_name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "argocd"
}

variable "eks_cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "eks_cluster_ca" {
  description = "EKS cluster CA certificate"
  type        = string
}

variable "eks_cluster_token" {
  description = "EKS cluster authentication token"
  type        = string
  sensitive   = true
}

