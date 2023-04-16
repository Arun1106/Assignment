resource "aws_security_group_rule" "example" {
  type                     = var.type_sg_rule
  from_port                = var.from_port_sg_rule
  to_port                  = var.to_port_sg_rule
  protocol                 = var.protocol_sg_rule
  security_group_id        = var.sg_id
  source_security_group_id = var.source_sg_id
}