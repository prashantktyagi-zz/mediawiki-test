module "mediawiki_db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "mediawiki-test"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  name     = "mediawiki"
  username = "admin"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]

  
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = {
    Owner       = "prashant"
    Environment = "stage"
    Managedby   = "tf"
  }

  # DB subnet group
  subnet_ids = module.vpc.private_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

}