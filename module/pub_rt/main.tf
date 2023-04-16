resource "aws_route_table" "example" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id

  }

  tags = merge(var.additional_tags, {
    Name         = "${var.Name}"
    project_name = "${var.project_name}"
    environment  = "${var.env}"
    createdby    = "${var.created_by}"
    datecreated  = "${var.date_created}"
  })
}