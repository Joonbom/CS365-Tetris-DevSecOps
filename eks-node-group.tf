resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = var.eksnode-group-name
  node_role_arn   = "arn:aws:iam::383799642623:role/LabRole"
  subnet_ids      = ["subnet-02c10b4145d12d5ca", "subnet-08cd09661bb682a06"]


  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3a.medium"]
  disk_size      = 20

}
