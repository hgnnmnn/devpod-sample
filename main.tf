provider "aws" {
  region = local.region
}

locals {
  region = "eu-central-1"
  name   = "hgn" ###change this to your name
}

### create a key pair
module "key_pair" {
  source             = "terraform-aws-modules/key-pair/aws"
  key_name           = "${local.name}-test-key"
  create_private_key = true
}

### create a vpc
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "${local.name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    terraform   = "true"
    environment = "test"
    creator     = "${local.name}"
  }
}

### create a security group
module "web_server_sg" {
  version             = "5.2.0"
  source              = "terraform-aws-modules/security-group/aws//modules/http-80"
  name                = "${local.name}-web-server-sg"
  description         = "Security group for web server of ${local.name}"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]
}

### create an ec2 instance
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name   = "${local.name}-web-server"

  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "test"
    creator     = "${local.name}"
  }
}


