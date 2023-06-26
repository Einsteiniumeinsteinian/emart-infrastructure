# Required Variables
variable "max_size" {
  description = "Maximum size of the Auto Scaling Group."
  type        = number
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group."
  type        = number
}

variable "launch_template_version" {
  description = "Nested argument with Launch template specification to use to launch instances."
  type        = number
}

variable "launch_template_id" {
  description = "ID for launch template"
  type        = string
}

variable "health_check_type" {
  description = "The type of health check to perform. Valid values: EC2 or ELB."
  type        = string
}

variable "desired_capacity" {
  description = "Number of instances that should be running in the group."
  type        = number
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs to launch resources in."
  type        = list(string)
}

variable "max_instance_lifetime" {
  description = "Time (in seconds) after an instance comes into service before checking health."
  type        = number
}

# Optional Variables
variable "name" {
  description = "Name of the Auto Scaling Group. Conflicts with name_prefix."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "capacity_rebalance" {
  description = "Whether capacity rebalance is enabled."
  type        = bool
  default     = null
}

variable "default_cooldown" {
  description = "Amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
  type        = number
  default     = null
}

variable "termination_policies" {
  description = "List of policies to decide how the instances in the Auto Scaling Group should be terminated."
  type        = list(string)
  default     = null
}

variable "load_balancers" {
  description = "List of elastic load balancer names to add to the autoscaling group names."
  type        = list(string)
  default     = null
}

variable "target_group_arns" {
  description = "Set of aws_alb_target_group ARNs for use with Application or Network Load Balancing."
  type        = list(string)
  default     = null
}

variable "suspended_processes" {
  description = "List of processes to suspend for the Auto Scaling Group."
  type        = list(string)
  default     = null
}

variable "enabled_metrics" {
  description = "List of metrics to collect."
  type        = list(string)
  default     = null
}

variable "service_linked_role_arn" {
  description = "ARN of the service-linked role that the ASG will use to call other AWS services."
  type        = string
  default     = null
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after an instance comes into service before checking health."
  type        = number
  default     = 300
}
