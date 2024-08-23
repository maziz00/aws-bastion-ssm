resource "aws_iam_role" "ebs_csi_driver_role" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::789:oidc-provider/oidc.eks.${var.region}.amazonaws.com/id/${var.eks_oidc_id}"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_oidc_id}:aud" = "sts.amazonaws.com"
          "oidc.eks.${var.region}.amazonaws.com/id/${var.eks_oidc_id}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "ebs_csi_driver_policy_attach" {
  name       = "AmazonEBSCSIDriverPolicy"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  roles      = [aws_iam_role.ebs_csi_driver_role.name]
}
