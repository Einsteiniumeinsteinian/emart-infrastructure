resource "aws_launch_template" "alt" {
  name                                 = var.launch_template_name.name
  image_id                             = var.image_id
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  name_prefix                          = var.launch_template_name.namestate ? null : var.launch_template_name.name_prefix
  ebs_optimized                        = var.ebs_optimized
  disable_api_stop                     = var.disable_api_stop
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  user_data                            = var.user_data
  vpc_security_group_ids               = var.vpc_security_group_ids

  block_device_mappings {
    device_name = var.block_device_mappings.device_name
    ebs {
      volume_size = var.block_device_mappings.volume_size
    }
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.tags.name}-launch-template-"
      Environment = var.tags.environment
    }
  }
}
