#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update OS packages
dnf update -y
dnf install -y git wget curl unzip

# Install java 21
dnf install -y java-21-amazon-corretto-devel

# Install Git
dnf install -y git

# Install and configure Docker
dnf install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
chmod 666 /var/run/docker.sock

# Install Jenkins Native
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
dnf install -y jenkins

# Add jenkins user
usermod -aG docker jenkins

# Start and Enable Jenkins
systemctl start jenkins
systemctl enable jenkins

# Set vm.max_map_count for SonarQube and Run Container
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sysctl -p

docker run -d --name sonarqube \
  --restart always \
  -p 9000:9000 \
  -e SONAR_WEB_CONTEXT=/sonarqube \
  sonarqube:community

# Add Trivy Repository and Install
cat << EOF | sudo tee -a /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF
dnf install -y trivy

# Install Terraform
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform

# Install jq
sudo yum install -y jq

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
