resource "aws_autoscaling_group" "example" {
  name                = var.name
  vpc_zone_identifier = var.subnet_id
  max_size            = var.max_size
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  launch_template {
    id      = var.id
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }

  target_group_arns    = var.target_group_arn
  health_check_type    = "ELB"
  termination_policies = ["OldestInstance"]
}

resource "aws_autoscaling_policy" "example" {
  autoscaling_group_name = var.name
  name                   = "asg-policy-01"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = var.target_value
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

  }
}