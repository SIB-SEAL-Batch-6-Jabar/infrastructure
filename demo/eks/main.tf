resource "aws_eks_cluster" "simanis-cluster" {
  name     = var.cluster_name
  version = "1.29"
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.aws_public_subnet
    security_group_ids = [ aws_security_group.simanis-sg.id ]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access = var.endpoint_public_access

  }
  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_eks_node_group" "simanis-ng" {
  cluster_name    = aws_eks_cluster.simanis-cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.cluster_role_arn
  subnet_ids      = var.aws_public_subnet
  instance_types  = var.instance_types
  

  remote_access {
    source_security_group_ids = [aws_security_group.simanis-sg.id]
    ec2_ssh_key               = var.key_pair
  }

  scaling_config {
    desired_size = var.scaling_desired_size
    max_size     = var.scaling_max_size
    min_size     = var.scaling_min_size
  }

  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_security_group" "simanis-sg" {
  name        = "simanis-g"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}