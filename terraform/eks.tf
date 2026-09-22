# Trust policy that allows the Amazon EKS service
# to assume the EKS cluster IAM role

data "aws_iam_policy_document" "eks_cluster_assume_role" { //creates the trust policy
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# IAM role used by the EKS control plane
resource "aws_iam_role" "eks_cluster_role" { //creates the actual IAM role
  name               = "ecommerce-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json

  tags = {

    Name = "ecommerce-eks-cluster-role"
  }
}

# Attach the Amazon EKS Cluster Policy to the cluster IAM role

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS Cluster
# AWS manages the Kubernetes control plane.

resource "aws_eks_cluster" "main" {
  name     = "ecommerce-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn //EKS Control Plane → Cluster IAM Role.

  vpc_config {
    subnet_ids = [aws_subnet.private_az1.id, aws_subnet.private_az2.id] //Tells EKS which subnets to use for the cluster's networking.
  }

  tags = {
    Name = "ecommerce-eks"
  }
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy] //Terraform wait until the required IAM policy is attached before creating the cluster
}

# Trust policy that allows EC2 worker nodes to assume the EKS node IAM role

data "aws_iam_policy_document" "eks_node_assume_role" { //creates the trust policy
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# IAM role used by the EKS Worker Node
resource "aws_iam_role" "eks_node_role" { //creates the actual IAM role
  name               = "ecommerce-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role.json

  tags = {

    Name = "ecommerce-eks-cluster-role"
  }
}

# Policies required by EKS worker nodes.

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_ecr_read_only" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

#EKS Managed Node Group 
#Creates and manages EC2 worker nodes for our Kubernetes cluster

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "ecommerce-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.private_az1.id, aws_subnet.private_az2.id]
  instance_types  = ["t3.medium"]
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
  tags = {
    Name = "ecommerce-eks-node"
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only,
  aws_iam_role_policy_attachment.eks_cni_policy]

}