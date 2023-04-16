resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  tags = merge(var.additional_tags, {
    Name         = "${var.Name}"
    project_name = "${var.project_name}"
    environment  = "${var.env}"
    createdby    = "${var.created_by}"
    datecreated  = "${var.date_created}"
  })
}