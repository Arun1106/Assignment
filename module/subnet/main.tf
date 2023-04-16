data "aws_availability_zones" "available" {
  state = "available"

  filter { # Only fetch Availability Zones (no Local Zones)
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
resource "aws_subnet" "main" {
  count      = length(var.subnet_cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = element(var.subnet_cidr_block, count.index)

  availability_zone = data.aws_availability_zones.available.names[count.index % var.no_of_azs]

  map_public_ip_on_launch = var.public_ip
  tags = merge(var.additional_tags, {
    Name         = "${var.project_name}-${var.env}-${element(var.Name, count.index)}"
    project_name = "${var.project_name}"
    environment  = "${var.env}"
    createdby    = "${var.created_by}"
    datecreated  = "${var.date_created}"
  })
}
 