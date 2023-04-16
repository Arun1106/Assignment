resource "aws_security_group" "sg" {
  name        = "${var.project_name}-${var.env}-${var.name}"
  description = var.description
  vpc_id      = var.vpc_id
  tags = merge(var.additional_tags, {
    Name         = "${var.project_name}-${var.env}-${var.name}"
    project_name = "${var.project_name}"
    environment  = "${var.env}"
    createdby    = "${var.created_by}"
    datecreated  = "${var.date_created}"
  })
}
