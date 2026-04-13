resource "aws_instance" "marcelo-v" {
  ami                    = "ami-0ea87431b78a82070"
  instance_type          = "t3.micro"
  key_name               = "chave-site-prod"
  vpc_security_group_ids = [aws_security_group.website-sg.id]
  iam_instance_profile   = "ECR-EC2-Role"

  tags = {
    Name        = "website-server"
    provisioned = "Terraform"
  }
}

resource "aws_security_group" "website-sg" {
  name   = "website-sg"
  vpc_id = "vpc-011bae919f5c506fb"

  tags = {
    Name    = "website-sg"
    Cliente = "Marcelo"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website-sg.id
  cidr_ipv4         = "131.72.46.28/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = "aws_security_group.website-sg"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}