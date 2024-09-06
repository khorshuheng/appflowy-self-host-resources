resource "aws_key_pair" "appflowy" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

resource "aws_instance" "appflowy" {
  ami                    = "ami-0d07675d294f17973" # Amazon linux
  key_name               = var.ssh_key_name
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.appflowy.id
  ipv6_address_count     = 1
  vpc_security_group_ids = ["${aws_security_group.appflowy.id}"]
  depends_on             = ["aws_internet_gateway.appflowy"]
}
