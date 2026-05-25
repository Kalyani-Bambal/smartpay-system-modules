data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.eks.certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.eks.token
}

# Helm Provider
provider "helm" {
  kubernetes {
    host = data.aws_eks_cluster.eks.endpoint

    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.eks.certificate_authority[0].data
    )

    token = data.aws_eks_cluster_auth.eks.token
  }
}

# ArgoCD Namespace
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

# ArgoCD Helm Release
resource "helm_release" "argocd" {
  name      = "argocd"

  namespace = kubernetes_namespace.argocd.metadata[0].name

  repository = "https://argoproj.github.io/argo-helm"

  chart   = "argo-cd"

  version = "7.3.8"

  timeout = 600

  depends_on = [
    kubernetes_namespace.argocd
  ]

  values = [
    <<EOF
server:
  service:
    type: LoadBalancer

configs:
  params:
    server.insecure: true
EOF
  ]
}