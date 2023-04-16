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

variable "project_name" {

}
variable "env" {

}
variable "created_by" {

}
variable "date_created" {

}
variable "Name" {
}

variable "additional_tags" {}
