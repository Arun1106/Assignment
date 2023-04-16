resource "aws_eip" "bar" {
  vpc                       = var.vpc
  instance                  = var.instance_id
  associate_with_private_ip = var.associate_with_private_ip
  address                   = var.address
  customer_owned_ipv4_pool  = var.customer_owned_ipv4_pool
  network_interface         = var.network_interface
  public_ipv4_pool          = var.public_ipv4_pool
  tags = merge(var.additional_tags, {
    Name         = "${var.Name}"
    project_name = "${var.project_name}"
    environment  = "${var.env}"
    createdby    = "${var.created_by}"
    datecreated  = "${var.date_created}"
  })
}