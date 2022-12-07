# Define Local Values in Terraform
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  eks_cluster_name = "${var.eks_cluster_id}"
  aws_iam_openid_connect_provider_extract_from_arn = element(split("oidc-provider/", "${var.aws_iam_openid_connect_provider_arn}"), 1)
} 