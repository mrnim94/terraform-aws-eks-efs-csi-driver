# Input Variables - Placeholder file
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "SAP"
}

variable "eks_cluster_id" {
  description = "EKS cluster ID/data.terraform_remote_state.eks.outputs.cluster_id"
  type = string
  default = ""
}

variable "aws_iam_openid_connect_provider_arn" {
  description = "The ARN assigned by AWS for this provider/data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn"
  type = string
  default = ""
}

variable "eks_cluster_endpoint" {
  description = "The hostname (in form of URI) of Kubernetes master/data.terraform_remote_state.eks.outputs.cluster_endpoint"
  type = string
  default = ""
}

variable "eks_cluster_certificate_authority_data" {
  description = "PEM-encoded root certificates bundle for TLS authentication./data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data"
  type = string
  default = ""
}