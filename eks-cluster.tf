resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = "arn:aws:iam::484183391590:role/LabRole"
  vpc_config {
    subnet_ids         = ["subnet-02c10b4145d12d5ca", "subnet-08cd09661bb682a06"]
    security_group_ids = [data.aws_security_group.sg-default.id]
  }

  version = 1.33

}
