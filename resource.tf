module "vpc" {
  source                           = "./module/vpc"
  vpc_cidr_block                   = var.vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_classiclink               = var.enable_classiclink
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  additional_tags                  = {}
  project_name                     = var.project_name
  env                              = var.env
  created_by                       = var.created_by
  date_created                     = local.timestamp
  Name                             = "${var.project_name}-${var.env}-vpc"
}

module "public_subnet" {
  source            = "./module/subnet"
  vpc_id            = module.vpc.vpc_id
  no_of_azs         = var.no_of_azs
  subnet_cidr_block = var.public_subnet_cidr
  public_ip         = "true"
  additional_tags   = {}
  project_name      = var.project_name
  env               = var.env
  created_by        = var.created_by
  date_created      = local.timestamp
  Name              = var.PublicSubnetName
}



module "private_subnet" {
  source            = "./module/subnet"
  vpc_id            = module.vpc.vpc_id
  no_of_azs         = var.no_of_azs
  subnet_cidr_block = var.private_subnet_cidr
  public_ip         = "false"
  additional_tags   = {}
  project_name      = var.project_name
  env               = var.env
  created_by        = var.created_by
  date_created      = local.timestamp
  Name              = var.PrivateSubnetName
}


module "ig" {
  source = "./module/igw"
  vpc_id = module.vpc.vpc_id
  additional_tags = {
  }
  project_name = var.project_name
  env          = var.env
  created_by   = var.created_by
  date_created = local.timestamp
  Name         = "${var.project_name}-${var.env}-igw-01"
}

module "eip" {
  source                    = "./module/eip"
  vpc                       = "true"
  instance_id               = ""
  associate_with_private_ip = ""
  address                   = ""
  customer_owned_ipv4_pool  = ""
  network_interface         = ""
  public_ipv4_pool          = ""
  additional_tags           = {}
  project_name              = var.project_name
  env                       = var.env
  created_by                = var.created_by
  Name                      = "${var.project_name}-${var.env}-nat-eip-01"
  date_created              = local.timestamp

}

module "nat" {
  source            = "./module/nat"
  allocation_id     = module.eip.eip_id
  subnet_id         = module.public_subnet.subnet_id[0]
  connectivity_type = "public"
  additional_tags   = {}
  project_name      = var.project_name
  env               = var.env
  created_by        = var.created_by
  name              = "${var.project_name}-${var.env}-natgw-01"
  date_created      = local.timestamp
}

module "privateroutetable" {
  source          = "./module/pvt_rt"
  nat_gateway_id  = module.nat.nat_gw_id
  vpc_id          = module.vpc.vpc_id
  additional_tags = {}
  project_name    = var.project_name
  env             = var.env
  created_by      = var.created_by
  Name            = "${var.project_name}-${var.env}-PrivateRouteTable"
  date_created    = local.timestamp
}

module "publicroutetable" {
  source          = "./module/pub_rt"
  gateway_id      = module.ig.internet_gw
  vpc_id          = module.vpc.vpc_id
  additional_tags = {}
  project_name    = var.project_name
  env             = var.env
  created_by      = var.created_by
  Name            = "${var.project_name}-${var.env}-PublicRouteTable"
  date_created    = local.timestamp
}

module "routetableassociatepublicsubnet" {
  source    = "./module/rt_associate"
  subnet_id = module.public_subnet.subnet_id
  rt_id     = module.publicroutetable.route_table_id
}

module "routetableassociateprivatesubnet" {
  source    = "./module/rt_associate"
  subnet_id = module.private_subnet.subnet_id
  rt_id     = module.privateroutetable.route_table_id
}

module "sg" {
  source          = "./module/sg"
  vpc_id          = module.vpc.vpc_id
  count           = length(var.sg)
  name            = lookup(var.sg[count.index], "name")
  description     = lookup(var.sg[count.index], "description")
  additional_tags = {}
  project_name    = var.project_name
  env             = var.env
  created_by      = var.created_by
  date_created    = local.timestamp
}
module "web_sg_rule" {
  source            = "./module/sg_rule1"
  count             = length(var.websg)
  type_sg_rule      = lookup(var.websg[count.index], "type")
  from_port_sg_rule = lookup(var.websg[count.index], "from_port")
  to_port_sg_rule   = lookup(var.websg[count.index], "to_port")
  protocol_sg_rule  = lookup(var.websg[count.index], "protocol")
  cidr_blocks       = lookup(var.websg[count.index], "cidr_blocks")
  sg_id             = module.sg[0].sg_id

}
module "app_sg_rule_main" {
  source            = "./module/sg_rule1"
  count             = length(var.appsg)
  type_sg_rule      = lookup(var.appsg[count.index], "type")
  from_port_sg_rule = lookup(var.appsg[count.index], "from_port")
  to_port_sg_rule   = lookup(var.appsg[count.index], "to_port")
  protocol_sg_rule  = lookup(var.appsg[count.index], "protocol")
  cidr_blocks       = lookup(var.appsg[count.index], "cidr_blocks")
  sg_id             = module.sg[1].sg_id

}
module "db_sg_rule_main" {
  source            = "./module/sg_rule1"
  count             = length(var.dbsg)
  type_sg_rule      = lookup(var.dbsg[count.index], "type")
  from_port_sg_rule = lookup(var.dbsg[count.index], "from_port")
  to_port_sg_rule   = lookup(var.dbsg[count.index], "to_port")
  protocol_sg_rule  = lookup(var.dbsg[count.index], "protocol")
  cidr_blocks       = lookup(var.dbsg[count.index], "cidr_blocks")
  sg_id             = module.sg[2].sg_id

}

module "app_sg_rule" {
  source            = "./module/sg_rule2"
  type_sg_rule      = "ingress"
  from_port_sg_rule = "3306"
  to_port_sg_rule   = "3306"
  protocol_sg_rule  = "tcp"
  sg_id             = module.sg[2].sg_id
  source_sg_id      = module.sg[1].sg_id

}

module "db_sg_rule" {
  source            = "./module/sg_rule2"
  type_sg_rule      = "ingress"
  from_port_sg_rule = "8080"
  to_port_sg_rule   = "8080"
  protocol_sg_rule  = "tcp"
  sg_id             = module.sg[1].sg_id
  source_sg_id      = module.sg[0].sg_id

}
module "rds_instance" {
  source            = "./module/rds"
  identifier        = var.identifier
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  sg_id             = ["${module.sg[2].sg_id}"]
  subnet_ids        = [module.private_subnet.subnet_id[2], module.private_subnet.subnet_id[3]]
  name              = "${var.project_name}-${var.env}-RDS-01"
}

locals {
  user_data_script = <<-EOF
    #!/bin/bash
    
    # Install Nginx
    sudo yum update
    sudo amazon-linux-extras install nginx1
    
    # Start Nginx
    sudo systemctl start nginx
    
    # Enable Nginx to start on system boot
    sudo systemctl enable nginx
  EOF
}

# Encode the user data as a BASE64 string
locals {
  user_data_base64 = base64encode(local.user_data_script)
}
module "launch_template" {
  source        = "./module/launch_template"
  name          = "${var.project_name}-${var.env}-lt-01"
  image_id      = var.image_id
  instance_type = var.instance_type
  sg_id         = [module.sg[0].sg_id]
  user_data     = local.user_data_base64
  key_name      = var.key_name
}


module "tg" {
  source = "./module/tg"
  name   = "${var.project_name}-${var.env}-tg-01"
  port   = 80
  vpc_id = module.vpc.vpc_id
}

module "lb" {
  source           = "./module/lb"
  name             = "${var.project_name}-${var.env}-lb-01"
  subnets          = [module.public_subnet.subnet_id[0], module.public_subnet.subnet_id[1]]
  security_groups  = [module.sg[0].sg_id]
  target_group_arn = module.tg.arn
}

module "asg" {
  source           = "./module/asg"
  name             = "${var.project_name}-${var.env}-asg-01"
  subnet_id        = [module.public_subnet.subnet_id[0], module.public_subnet.subnet_id[1]]
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  id               = module.launch_template.id
  target_value     = 50
  target_group_arn = [module.tg.arn]
}

