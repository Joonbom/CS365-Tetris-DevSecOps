terraform {
  required_providers {
    aws = {
      source = "opentofu/aws"
      version = "6.37.0"
    }
  }
  backend "s3" {
    bucket       = "tertis-tf-bucket"
    region       = "us-east-1"
    key          = "terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../module/vpc"

  vpc-name    = "Jenkins-VPC"
  igw-name    = "Jenkins-IGW"
  rt-name     = "Jenkins-RT"
  subnet-name = "Jenkins-Public-Subnet"
  sg-name     = "Jenkins-SG"
  aws-region = "us-east-1"
}

module "ec2" {
  source = "../module/ec2"

  instance-type = "t3.large"
  instance-name = "Jenkins-Server"
  key-name = "jenkins-key"
  public-subnet-id = module.vpc.public-subnet-id
  security-group-id = module.vpc.security-group-id
  instance-profile-name = "LabInstanceProfile"
  aws-region = "us-east-1"
}

