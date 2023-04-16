resource "aws_launch_template" "example" {
  name_prefix   = var.name
  image_id      = var.image_id
  instance_type = var.instance_type

  user_data = var.user_data
  key_name  = var.key_name
  network_interfaces {
    security_groups = var.sg_id
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 20
      delete_on_termination = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

