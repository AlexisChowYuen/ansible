// Output all public IP addresses for instances controller target1 and target2

output "controller_public_ip" {
  description = "Public IP address of controller"
  value = aws_eip.controller.public_ip
}

output "target1_public_ip" {
  description = "Public IP address of target1"
  value = aws_eip.tg1.public_ip
}

output "target2_public_ip" {
  description = "Public IP address of target2"
  value = aws_eip.tg2.public_ip
}