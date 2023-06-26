variable "network" {
  type = object({
    cidr_block        = string
    Azs               = list(string)
    private_subnet    = list(string)
    public_subnet     = list(string)
    create_default_sg = bool
  })
  default = {
    Azs               = ["eu-north-1a", "eu-north-1b"]
    cidr_block        = "10.10.10.0/24"
    private_subnet    = ["10.10.10.0/26", "10.10.10.64/26"]
    public_subnet     = ["10.10.10.128/26", "10.10.10.192/26"]
    create_default_sg = true
  }
}

variable "security_groups" {
  description = "All security groups variables"
  type = list(object({
    name        = string
    description = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    }))
  }))
  default = [
    {
      name        = "jump_server_sg"
      description = "Jump Server Security Group"
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows inbound SSH traffic into Jump Server"
        },
      ]
      egress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows out bound SSH traffic from Jump Server"
        }
      ]
    },
    {
      name        = "load_balancer_sg"
      description = "Load Balancer Security Group"
      ingress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows inbound HTTP traffic into Load Balancer"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows inbound HTTPS traffic into Load Balancer"
        }
      ]
      egress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows outbound HTTP traffic from Load Balancer"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows outbound HTTPs traffic from Load Balancer"
        }
      ]
    },
    {
      name        = "internal_server_sg"
      description = "Internal Server Security Group"
      ingress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["10.10.10.0/24"]
          description = "Allows inbound HTTP traffic from Internal Server"
        },
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["10.10.10.0/24"]
          description = "Allows inbound SSH traffic from Internal Server"
        },
      ]
      egress_rules = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows outbound HTTP traffic from Internal Serverr"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "Allows outbound HTTPS traffic from Internal Serverr"
        },
      ]
    },
  ]
}
