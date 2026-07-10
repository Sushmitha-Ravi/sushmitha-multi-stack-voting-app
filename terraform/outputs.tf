output "frontend_public_ip" {
  description = "Public IP of the frontend/bastion EC2 instance"
  value       = aws_instance.frontend.public_ip
}

output "frontend_private_ip" {
  description = "Private IP of the frontend EC2 instance"
  value       = aws_instance.frontend.private_ip
}

output "backend_private_ip" {
  description = "Private IP of the backend EC2 instance"
  value       = aws_instance.backend.private_ip
}

output "database_private_ip" {
  description = "Private IP of the database EC2 instance"
  value       = aws_instance.database.private_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
