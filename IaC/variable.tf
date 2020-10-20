# What will be the environment name ?
variable "env" {
 default = "stage"
}

# Which AWS region you are creating this environment ?
variable "region" {
 default = "us-east-1"
}

# vpc id ?
variable "eks_instance_type" {
 default = "t2.small"
}


# vpc cidr ?
variable "vpc_cidr" {
 default = "10.0.0.0/16"
}

variable "az_list" {
 type = list
 default = ["us-east-1a", "us-east-1b"]
}

# subnet list 
variable "private_subnets_cidr" {
 type = list
 default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets_cidr" {
 type = list
 default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}


# EKS cluster name ?
variable "cluster_name" {
 default = "mediawiki-app"
}

# EKS cluster version ?
variable "cluster_version" {
 default = "1.17"
}