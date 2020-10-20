module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "mediawiki"
  cidr = var.vpc_cidr

  azs             = var.az_list
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "allow_db"
  description = "Allow mysql inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "custom TCP from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner       = "prashant"
    Environment = "stage"
    Managedby   = "tf"
  }
}