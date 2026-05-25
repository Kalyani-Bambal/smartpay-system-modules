output "cluster_name" {
    value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
    value = aws_eks_cluster.this.endpoint
}

output "cluster_ca" {
    value = aws_eks_cluster.this.certificate_authority[0].data
}

output "eks_cluster_token" {
  value = data.aws_eks_cluster_auth.eks.token
  sensitive = true
}