project_name = "hyperverge"
env          = "demo"
created_by   = "arun"
region       = "ap-south-1"


##vpc module values##
vpc_cidr_block                   = "172.16.0.0/16"
instance_tenancy                 = "default"
enable_dns_support               = "true"
enable_dns_hostnames             = "true"
enable_classiclink               = "false"
assign_generated_ipv6_cidr_block = "false"

##subnet module values##

no_of_azs           = "2"
PublicSubnetName    = ["ALBPBSN-01", "ALBPBSN-02"]
public_subnet_cidr  = ["172.16.1.0/24", "172.16.2.0/24"]
PrivateSubnetName   = ["APPPRSN-01", "APPPRSN-02", "DBPRSN-01", "DBPRSN-02"]
private_subnet_cidr = ["172.16.3.0/24", "172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]


##sg module values$$
sg = [
  { name = "web", description = "web sg" },
  { name = "app", description = "app sg" },
  { name = "db", description = "db sg" }
]

websg = [
  {
    type        = "egress",
    from_port   = "0",
    to_port     = "0",
    protocol    = "-1",
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress",
    from_port   = "80",
    to_port     = "80",
    protocol    = "tcp",
    cidr_blocks = ["0.0.0.0/0"]
    }, {
    type        = "ingress",
    from_port   = "443",
    to_port     = "443",
    protocol    = "tcp",
    cidr_blocks = ["0.0.0.0/0"]
}]
appsg = [
  {
    type        = "egress",
    from_port   = "0",
    to_port     = "0",
    protocol    = "-1",
    cidr_blocks = ["0.0.0.0/0"]
}]

dbsg = [
  {
    type        = "egress",
    from_port   = "0",
    to_port     = "0",
    protocol    = "-1",
    cidr_blocks = ["0.0.0.0/0"]
}]


## rds module values##
identifier        = "example-db"
allocated_storage = 10
storage_type      = "gp2"
engine            = "mysql"
engine_version    = "5.7"
instance_class    = "db.t2.micro"
db_name           = "example_db"
db_username       = "example_user"
db_password       = "example_password"
db_sg_name        = "example-subnet-group"

##launch template module values##
image_id         = "ami-076e3a557efe1aa9c"
instance_type    = "t2.micro"
instance_profile = ""
key_name         = "demo"

##asg module values##
min_size         = 1
max_size         = 2
desired_capacity = 1