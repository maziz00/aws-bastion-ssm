variable "region" {
  default = "me-central-1"
}

variable "eks_oidc_id" {
  description = "OIDC provider ID for the EKS cluster"
  type        = string
  default     = "XXX"
}


variable "eks_cluster_name" {
    default = "prod-eks"
}