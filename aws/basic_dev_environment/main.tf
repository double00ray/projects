provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "us-east-2"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-vpc"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "marcusdev-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24",]
  public_subnets  = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24",]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_db_subnet_group" "marcusdev-subnet-group" {
  name       = "marcusdev-subnet-group"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "marcusdev-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name   = "marcusdev_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["68.113.81.200/32","0.0.0.0/0"]
  }
  

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "marcusdev_rds"
  }
}


resource "aws_db_parameter_group" "marcusdev-subnet-param" {
  name   = "marcusdevsubnetparam"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "marcusdevrdsinstance" {
  identifier             = "marcusdev"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  username               = "marcusdevadmin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.marcusdev-subnet-group.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.marcusdev-subnet-param.name
  publicly_accessible    = false
  skip_final_snapshot    = true
}

terraform {
  backend "s3" {
    bucket = "ardee-dev-terraform-state"
    key    = "./terraform.tfstate"
    region = "us-east-2"
  }
}
