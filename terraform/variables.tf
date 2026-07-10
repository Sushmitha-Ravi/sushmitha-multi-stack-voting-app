variable "aws_region" {
  description = "AWS region for the project"
  type        = string
}

variable "project_name" {
  description = "Project name used for AWS resource names"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Public IP CIDR allowed to SSH into the frontend/bastion instance"
  type        = string
}
