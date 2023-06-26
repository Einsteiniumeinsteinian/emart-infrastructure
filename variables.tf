# environment
variable "tags" {
  type = object({
    name : string
    environment : string
  })
  default = {
    name        = "amorserv"
    environment = "test"
  }
}

variable "login" {
  type = object({
    username = string
    pub_key  = string
    priv_key = string
  })
  default = {
    priv_key = "./secrets/ssh/amorserv.pem"
    pub_key  = "./secrets/ssh/amorserv.pub"
    username = "ubuntu"
  }
}

variable "domain_setup" {
  description = "all domain and cert properties"
  type = object({
    private_key = string
    cert_body   = string
    domainName  = string
    record      = string
  })
  default = {
    private_key = "/home/einstein/Documents/Scandiweb/secrets/cert/private.key"
    cert_body   = "/home/einstein/Documents/Scandiweb/secrets/cert/testdomanainxyz.crt"
    domainName  = "testdomanainxyz.site"
    record      = "www.testdomanainxyz.site"

  }
}

variable "ec2" {
  description = "Server Properties"
  type = object({
    jumpserver = object({
      instance_type = string
    })
  })

  default = {
    jumpserver = {
      instance_type = "t3.micro"
    }
  }
}
