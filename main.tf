data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    # Updated pattern to capture modern Bitnami naming conventions
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami Marketplace Owner ID
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.nano"

  tags = {
    Name = "HelloWorld"
  }
}
