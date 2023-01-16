Example:
Modules need to access the `terraform.tfstate` file.
U mustn't declare so many many variables


If your eks cluster was set up by eks module, You can refer to below configuration.
```hcl

# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-on-aws-eks-nim"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = var.aws_region
  }
}

module "eks-efs-csi-driver" {
  source  = "mrnim94/eks-efs-csi-driver/aws"
  version = "1.0.0"

  aws_region = var.aws_region
  environment = "dev"
  business_divsion = "SAP"

 eks_cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data
 eks_cluster_endpoint = data.terraform_remote_state.eks.outputs.cluster_endpoint
 eks_cluster_id = data.terraform_remote_state.eks.outputs.cluster_id
 aws_iam_openid_connect_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn
}

```

anything else

```hcl
data "aws_eks_cluster" "dev-nimtechnology-engines" {
  name = var.cluster_id
}

data "aws_vpc" "dev-nimtechnology-engine" {
  id = data.aws_eks_cluster.dev-nimtechnology-engines.vpc_config[0].vpc_id
}

module "eks-efs-storageclass" {
  source  = "mrnim94/eks-efs-storageclass/aws"
  version = "1.0.5"

  efs_name = "${var.business_divsion}-${var.environment}"

  eks_cluster_certificate_authority_data = data.aws_eks_cluster.dev-nimtechnology-engines.certificate_authority[0].data
  eks_cluster_endpoint = data.aws_eks_cluster.dev-nimtechnology-engines.endpoint
  eks_cluster_id = var.cluster_id

  eks_private_subnets = data.aws_eks_cluster.dev-nimtechnology-engines.vpc_config[0].subnet_ids
  vpc_cidr_block = data.aws_vpc.dev-nimtechnology-engine.cidr_block
  vpc_id = data.aws_eks_cluster.dev-nimtechnology-engines.vpc_config[0].vpc_id
}
```

Example Input:

```hcl
eks_cluster_certificate_authority_data = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSRlgvZndHRmMKeU13PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
eks_cluster_endpoint = "https://54BDECE91CB74A3682E45D44CB7533CE.gr7.us-west-2.eks.amazonaws.com"
eks_cluster_id = "devops-nimtechnology"
aws_iam_openid_connect_provider_arn = "arn:aws:iam::250887682577:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/54BDECE91CB74A3682E45D44CB7533CE"
```
