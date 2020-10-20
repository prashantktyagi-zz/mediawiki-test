### Terraform Backend ###
terraform {
  backend "s3" {

   bucket = "terraform-state-mediawiki"
   key    = "TerraformState"
   region = "us-east-1"

  }
}

locals {
  tags = {
    Owner       = "prashant"
    Environment = "stage"
    Managedby   = "tf"
  }
}

provider "aws" {
  region = "us-east-1"
}


data "aws_eks_cluster" "cluster" {
  name = module.mediawiki-eks-kcl.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.mediawiki-eks-kcl.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "mediawiki-eks-kcl" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "${var.cluster_name}"
  cluster_version = "${var.cluster_version}"
  subnets         = "${module.vpc.public_subnets}"
  vpc_id          = "${module.vpc.vpc_id}"

  worker_groups = [
    {
      instance_type = "${var.eks_instance_type}"
      asg_max_size  = 1
    }
  ]
}
