# Required Variables

variable "image_id" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to launch."
  type        = string
}

variable "vpc_security_group_ids" {
  description = " list of security group IDs to associate with."
  type        = list(string)
}

variable "key_name" {
  description = "The name of the key pair to use for the instance."
  type        = string
  default     = null
}

variable "tags" {
  type = object({
    name : string
    environment : string
  })
  default = {
    environment = ""
    name : ""
  }
}

variable "launch_template_name" {
  description = "Creates a name or a unique name beginning with the specified prefix. NB You cannot have name and name_preficx set as name would take presidence"
  type = object({
    name        = string
    name_prefix = string
    namestate   = bool
  })

  default = {
    namestate   = false
    name        = null
    name_prefix = null
  }
}

variable "ebs_optimized" {
  description = "Specifies whether the instance is optimized for Amazon EBS I/O."
  type        = bool
  default     = null
}

variable "disable_api_stop" {
  description = "Specifies whether instances in this launch template are enabled for API termination."
  type        = bool
  default     = null
}

variable "disable_api_termination" {
  description = "Specifies whether instances in this launch template are enabled for API stop actions."
  type        = bool
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "Specifies whether the instance stops or terminates when you initiate shutdown from the instance."
  type        = string
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = "The block device mapping configuration for the instance."
  type = object({
    device_name = string
    volume_size = number
  })

  default = {
    device_name = "/dev/sdf"
    volume_size = 10
  }
}
variable "enable_monitoring" {
  description = "The monitoring option for the instance."
  type        = bool
  default     = false
}
