module "custom_vpc_config" {
  source          = "./modules/vpc-module"
  network         = var.network
  tags            = var.tags
  security_groups = var.security_groups
}

module "custom_launch_template" {
  source        = "./modules/launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  user_data              = filebase64("./bootstrap/II.sh")
  key_name               = aws_key_pair.connection_key.key_name
  ebs_optimized          = true
  vpc_security_group_ids = [module.custom_vpc_config.vpc.security_group_id[2]]
}

resource "aws_key_pair" "connection_key" {
  key_name   = "amorserv"
  public_key = file(var.login.pub_key)
}

module "custom_asg_config" {
  source                    = "./modules/auto-scaling"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 1
  health_check_type         = "ELB"
  vpc_zone_identifier       = [module.custom_vpc_config.vpc.private_subnet_id[0], module.custom_vpc_config.vpc.private_subnet_id[1]]
  launch_template_id        = module.custom_launch_template.id
  launch_template_version   = module.custom_launch_template.latest_version
  health_check_grace_period = "300"
  depends_on                = [module.custom_vpc_config]
  termination_policies      = ["OldestInstance", "ClosestToNextInstanceHour", "OldestLaunchTemplate", "Default"]
  name                      = var.tags.name
  target_group_arns         = [aws_lb_target_group.frontend_target_group.arn]
  max_instance_lifetime     = 1728000 // 20days
}

resource "aws_instance" "jump_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2.jumpserver.instance_type
  vpc_security_group_ids = [module.custom_vpc_config.vpc.security_group_id[0]]
  subnet_id              = module.custom_vpc_config.vpc.public_subnet_id[0]
  key_name               = aws_key_pair.connection_key.key_name
  depends_on             = [module.custom_vpc_config, aws_key_pair.connection_key]

  tags = {
    Name = "${var.tags.name}_jumpserver"
    environment : var.tags.environment
  }
}
