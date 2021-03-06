module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  node_groups = {
    eks_nodes_1 = {
      desired_capacity = 2
      max_capacity     = 6
      min_capaicty     = 2
      subnet_ids       = module.vpc.private_subnets[0]
      instance_type = "t3.xlarge"
    }
    eks_nodes_2 = {
      desired_capacity = 2
      max_capacity     = 6
      min_capaicty     = 2
      subnet_ids       = module.vpc.private_subnets[1]
      instance_type = "t3.xlarge"
    }
    eks_nodes_3 = {
      desired_capacity = 2
      max_capacity     = 6
      min_capaicty     = 2
      subnet_ids       = module.vpc.private_subnets[2]
      instance_type = "t3.xlarge"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}