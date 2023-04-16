resource "aws_route_table_association" "a" {
  count          = length(var.subnet_id)
  subnet_id      = element(var.subnet_id, count.index)
  route_table_id = var.rt_id
}