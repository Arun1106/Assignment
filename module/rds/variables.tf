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


variable "sg_id" {
  type        = list(string)
  description = "The list of security group IDs for the RDS instance"
}

variable "name" {
  type        = string
  description = "The name of the RDS instance"
}
variable "subnet_ids" {}
