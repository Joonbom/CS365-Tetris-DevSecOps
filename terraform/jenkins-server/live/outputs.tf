output "jenkins-server-name" {
  value = module.ec2.instance-name
}

output "jenkins-server-public-ip" {
  value = module.ec2.public-ip
}

output "jenkins-vpc-id" {
  value = module.vpc.vpc-id
}

output "jenkins-subnet-id" {
  value = module.vpc.public-subnet-id
}