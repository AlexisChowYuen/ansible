resource "aws_instance" "controller" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = "ansible"

  user_data = file("user-data.sh")

  provisioner "file" {
    source      = "../ansible/"
    destination = "/home/ubuntu"
    connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = aws_eip.controller.public_ip
      private_key = file("../ansible/ansible.pem")
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/ansible.pem"
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = aws_eip.controller.public_ip
      private_key = file("../ansible/ansible.pem")
    }
  }

  network_interface {
    network_interface_id = aws_network_interface.controller.id
    device_index = 0
  }

  tags = {
    Name = "controller"
  }
}

resource "aws_eip" "controller" {
  network_interface = aws_network_interface.controller.id
  vpc      = true
  associate_with_private_ip = "10.0.0.6"
  depends_on                = [aws_internet_gateway.gw]
}

resource "aws_network_interface" "controller" {
  subnet_id = aws_subnet.subnet.id
  private_ips = ["10.0.0.6"]
  security_groups = [ aws_security_group.allow_ssh.id ]
  tags = {
      Name = "controller-nic"
  }
}