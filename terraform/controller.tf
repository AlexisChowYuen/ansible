resource "aws_instance" "controller" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = "ansible"

  user_data = file("user-data.sh")

  network_interface {
    network_interface_id = aws_network_interface.controller.id
    device_index = 0
  }

  tags = {
    Name = "controller"
  }
}

resource "aws_eip" "controller" {
  instance = aws_instance.controller.id
  vpc      = true
}

resource "aws_network_interface" "controller" {
  subnet_id = aws_subnet.subnet.id
  private_ips = ["10.0.0.6"]
  security_groups = [ aws_security_group.allow_ssh.id ]
  tags = {
      Name = "controller-nic"
  }
}