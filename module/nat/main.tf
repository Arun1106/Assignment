resource "aws_nat_gateway" "example" {
  allocation_id     = var.allocation_id
  subnet_id         = var.subnet_id
  connectivity_type = var.connectivity_type
  tags = merge(var.additional_tags, {
    Name         = "${var.name}"
    project_name = "${var.project_name}"
    createdby    = "${var.created_by}"
    datecreated  = "${var.date_created}"
  })
}
