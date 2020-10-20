### vpc ###
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "private_subnets_id" {
  value = "${module.vpc.private_subnets}"
}

output "public_subnets_id" {
  value = "${module.vpc.public_subnets}"
}

output "db_sg_id" {
  value = "${aws_security_group.rds_sg.id}"
}

output "rds_endpoint" {
  value = "${module.mediawiki_db.this_db_instance_address}"
}