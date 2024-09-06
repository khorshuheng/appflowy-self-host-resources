resource "aws_vpc" "appflowy" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "10.0.0.0/16"
}

resource "aws_subnet" "appflowy" {
  vpc_id                  = aws_vpc.appflowy.id
  cidr_block              = cidrsubnet(aws_vpc.appflowy.cidr_block, 4, 1)
  map_public_ip_on_launch = false

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.appflowy.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true
}

resource "aws_internet_gateway" "appflowy" {
  vpc_id = aws_vpc.appflowy.id
}

resource "aws_default_route_table" "appflowy" {
  default_route_table_id = aws_vpc.appflowy.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.appflowy.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.appflowy.id
  }
}

resource "aws_route_table_association" "appflowy" {
  subnet_id      = aws_subnet.appflowy.id
  route_table_id = aws_default_route_table.appflowy.id
}

resource "aws_security_group" "appflowy" {
  name   = "appflowy"
  vpc_id = aws_vpc.appflowy.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = [var.ssh_allowed_ipv6_cidr]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}
