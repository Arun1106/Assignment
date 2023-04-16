variable "created_by" {}
variable "env" {}
variable "project_name" {}
variable "region" {}

#########################################


variable "vpc_cidr_block" {
  type = string
}
variable "instance_tenancy" {
  type    = string
  default = "default"
}
variable "enable_dns_support" {
  type    = bool
  default = "true"
}
variable "enable_dns_hostnames" {
  type    = bool
  default = "false"
}
variable "enable_classiclink" {
  type    = bool
  default = "false"
}
variable "assign_generated_ipv6_cidr_block" {
  type    = bool
  default = "false"
}


##############################################

variable "public_subnet_cidr" {

}
variable "private_subnet_cidr" {

}

variable "PublicSubnetName" {

}
variable "PrivateSubnetName" {

}
variable "no_of_azs" {

}
#################################################
variable "sg" {}

variable "websg" {}
variable "appsg" {}
variable "dbsg" {}
################################################
variable "identifier" {
  type        = string
  description = "The identifier of the RDS instance"
}

variable "allocated_storage" {
  type        = number
  description = "The amount of allocated storage for the RDS instance"
}

variable "storage_type" {
  type        = string
  description = "The storage type for the RDS instance"
}

variable "engine" {
  type        = string
  description = "The database engine for the RDS instance"
}

variable "engine_version" {
  type        = string
  description = "The version of the database engine for the RDS instance"
}

variable "instance_class" {
  type        = string
  description = "The instance class for the RDS instance"
}

variable "db_name" {
  type        = string
  description = "The name of the database for the RDS instance"
}

variable "db_username" {
  type        = string
  description = "The username for the database user of the RDS instance"
}

variable "db_password" {
  type        = string
  description = "The password for the database user of the RDS instance"
}

variable "db_sg_name" {
  type        = string
  description = "The name of the DB subnet group for the RDS instance"
}



##########################################

variable "image_id" {}
variable "instance_type" {}
variable "key_name" {}

##############################################
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}