resource "aws_autoscaling_group" "asg" {
  name                      = var.name
  name_prefix               = var.name_prefix
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.vpc_zone_identifier
  capacity_rebalance        = var.capacity_rebalance
  default_cooldown          = var.default_cooldown
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  target_group_arns         = var.target_group_arns
  termination_policies      = var.termination_policies
  enabled_metrics           = var.enabled_metrics
  suspended_processes       = var.suspended_processes
  max_instance_lifetime     = var.max_instance_lifetime
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  lifecycle {
    ignore_changes = [desired_capacity, target_group_arns]
  }

  instance_refresh {
    strategy = "Rolling"
  }
}
