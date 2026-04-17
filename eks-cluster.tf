resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = "arn:aws:iam::383799642623:role/LabRole"
  vpc_config {
    subnet_ids = [
      data.aws_subnet.subnet_az1.id, 
      aws_subnet.public-subnet2.id
    ]
    security_group_ids = [data.aws_security_group.sg-default.id]
  }

  version = 1.33

}
