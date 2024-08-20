output "instance-type" {
  value = aws_instance.example.instance_type
}

output "instance-state" {
  value = aws_instance.example.instance_state
}

output "public-ip" {
  value = aws_instance.example.public_ip
}

output "subnet-id" {
  value = aws_instance.example.subnet_id
}
