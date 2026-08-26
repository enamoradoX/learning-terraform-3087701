variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.micro"
}

variable "ami_filter" {

  description = "Name filter and owner for AMI"

  type = object ({
    name = string
    owner = string
  })

  default = {
    name = "amzn2-ami-hvm-*-x86_64-gp2"
    owner = "amazon"
  }
}

variable "environment" {

  description = "Deployment Environment"

  type=object({
    name = string
    network_prefix = string
  })

  default = {
    name = "dev"
    network_prefix = "10.0"
  }
} 

resource "aws_security_group" "blog" {
  name   = "blog"
  tags   = {
    Terraform = "true"
  }
  vpc_id = module.blog_vpc.vpc_id
}

resource "aws_security_group_rule" "blog_http_in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog.id
}

resource "aws_security_group_rule" "blog_https_in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog.id
}

resource "aws_security_group_rule" "blog_everything_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog.id
}

variable "min_size" {
  description = "Minimun number of instances in the ASG"
  default = 1
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  default = 2
}

