module "vpc" {
  source                  = "./demo/vpc"
  tags                    = {"Name": "simanis", "Env":"demo"}
  vpc_cidr                = "10.0.0.0/16"
  public_sn_count         = 2
  avaibility_zone         = ["us-east-1a", "us-east-1b"]
  public_cidrs            = ["10.0.1.0/24", "10.0.2.0/24"]
  rt_route_cidr_block     = "0.0.0.0/0"
  map_public_ip_on_launch = true
}

module "ecr" {
  source = "./demo/ecr"
  repo   = [ "frontend", "broker", "worker" ]
  tags   = {"Name": "simanis", "Env":"demo"}
}

module "eks" {
  source                  = "./demo/eks"
  tags                    = {"Name": "simanis", "Env":"demo"}
  aws_public_subnet       = module.vpc.aws_public_subnet
  vpc_id                  = module.vpc.vpc_id
  cluster_name            = "simanis-cluster"
  endpoint_public_access  = true
  endpoint_private_access = false
  public_access_cidrs     = ["0.0.0.0/0"]
  node_group_name         = "simanis"
  scaling_desired_size    = 2
  scaling_max_size        = 3
  scaling_min_size        = 2
  instance_types          = ["t3.medium"]
  key_pair                = "vockey"
  cluster_role_arn = "arn:aws:iam::646758500755:role/LabRole"
}

module "rds" {
  source = "./demo/rds"
  tags   = {"Name": "simanis", "Env":"demo"}
  engine = "postgres"
  engine_version = "16.2"
  avaibility_zone = "us-east-1a"
  identifier = "simanis"
  username = "postgres"
  password = "demo2024"
  instance_class = "db.t3.micro"
  storage_type = "gp3"
  allocated_storage = "20"
  aws_public_subnet = module.vpc.aws_public_subnet
  vpc_id = module.vpc.vpc_id
}

module "s3" {
  source = "./demo/s3"
  tags   = {"Name": "simanis", "Env":"demo"}
  bucket = "simanis-demo"
  aws_region = "us-east-1"
}