resource "aws_instance" "website_server" {
  ami                    = "ami-068c0051b15cdb816" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  key_name               = "chave-site-prod"
  vpc_security_group_ids = [aws_security_group.web-site-sg.id]
  iam_instance_profile   = "ECR-EC2-Role"

  tags = {
    Name          = "web-site-server"
    ProvisionedBy = "Terraform"
  }
}

resource "aws_security_group" "web-site-sg" {
  name   = "web-site-sg"
  vpc_id = "vpc-069bd57222f9bc62d" # Substitua pelo ID do seu VPC

  tags = {
    Name          = "web-site-sg"
    ProvisionedBy = "Terraform"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web-site-sg.id
  cidr_ipv4         = "170.84.165.14/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web-site-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.web-site-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.web-site-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1

}