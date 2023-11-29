provider "aws" {
    region ="us-east-1"
    access_key = var.AWS_ACCESS_KEY_ID != "" ? var.AWS_ACCESS_KEY_ID : null
    secret_key = var.AWS_SECRET_ACCESS_KEY != "" ? var.AWS_SECRET_ACCESS_KEY : null
}



# Create VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway = true
}

resource "aws_springboot-cluster" "springboot-cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.springboot-cluster.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets  # Use private subnets for EKS cluster
  }
}

resource "aws_iam_role" "springboot-cluster" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}


resource "aws_iam_role_policy_attachment" "springboot-cluster_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.springboot-cluster.name
}