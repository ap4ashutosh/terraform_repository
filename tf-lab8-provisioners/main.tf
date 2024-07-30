provider "aws" {
  region = "us-east-1"
}

provider "tls" {}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.2.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.name.id
}

resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_security_group" "name" {
  name   = "my_ec2_security_group"
  vpc_id = aws_vpc.name.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-*-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.medium"
  subnet_id                   = aws_subnet.subnet1.id
  vpc_security_group_ids      = [aws_security_group.name.id]
  associate_public_ip_address = true
  get_password_data = true
  tags = {
    Name = "my_ec2_instance"
  }
}

output "amis" {
  value = {
    ami   = data.aws_ami.ubuntu.id
    name  = data.aws_ami.ubuntu.name
    value = "The ami id is ${data.aws_ami.ubuntu.id} and the name is ${data.aws_ami.ubuntu.name}"
    value = "The public ip is ${aws_instance.my_instance.public_ip}"
  }
  description = "value of amis"
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "local_file" "pvt_key_pem" {
  content = tls_private_key.generated.private_key_pem
  filename = "pvt_key_pem"
}