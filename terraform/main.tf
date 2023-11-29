provider "aws" {
    region ="us-east-1"
}

resource "aws_instance" "ec2_for_springboot" {
    ami = "ami-06aa3f7caf3a30282"
    instance_type = "t2.micro"
    tags ={
        Name = "ec2_for_springboot"}
}

resource "aws_iam_role" "eks_cluster" {
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

resource "aws_iam_policy_attachment" "eks_cluster_admin_attachment" {
  name       = "eks-cluster-admin-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  roles      = [aws_iam_role.eks_cluster.name]
}
