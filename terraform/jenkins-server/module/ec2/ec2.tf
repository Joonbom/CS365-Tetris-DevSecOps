data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon-linux.id
  instance_type          = var.instance-type
  // key_name               = var.key-name
  subnet_id              = var.public-subnet-id
  vpc_security_group_ids = [var.security-group-id]
  iam_instance_profile   = var.instance-profile-name
  root_block_device {
    volume_size = 30
  }
  user_data = templatefile("${path.module}/tools-install.sh", {})

  tags = {
    Name = var.instance-name
  }
}