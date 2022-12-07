# EFS CSI Helm Release Outputs
output "efs_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value = helm_release.efs_csi_driver.metadata
}

# # VPC Private Subnets
# output "private_subnets" {
#   description = "List of IDs of private subnets"
#   value       = data.terraform_remote_state.eks.outputs.private_subnets
# }
