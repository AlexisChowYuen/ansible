resource "aws_instance" "target1" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = "ansible"

  user_data = file("user-data.sh")

  network_interface {
    network_interface_id = aws_network_interface.target1.id
    device_index = 0
  }

  tags = {
    Name = "target1"
  }
}

resource "aws_eip" "tg1" {
  network_interface = aws_network_interface.target1.id
  vpc      = true
  associate_with_private_ip = "10.0.0.7"
  depends_on                = [aws_internet_gateway.gw, aws_instance.target1]
}

resource "aws_network_interface" "target1" {
  subnet_id = aws_subnet.subnet.id
  private_ips = ["10.0.0.7"]
  security_groups = [ aws_security_group.allow_ssh.id ]
  tags = {
      Name = "target1-nic"
  }   
}