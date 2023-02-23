resource "aws_instance" "target2" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = "ansible"

  user_data = file("user-data.sh")
  
  network_interface {
    network_interface_id = aws_network_interface.target2.id
    device_index = 0
  }

  tags = {
    Name = "target2"
  }
}

resource "aws_eip" "tg2" {
  instance = aws_instance.target2.id
  vpc      = true
}

resource "aws_network_interface" "target2" {
  subnet_id = aws_subnet.subnet.id
  private_ips = ["10.0.0.8"]
  security_groups = [ aws_security_group.allow_ssh.id ]
  tags = {
    Name = "target2-nic"
  }
}