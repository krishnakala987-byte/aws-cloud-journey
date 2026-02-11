variable "region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-xxxxxxxx"
}
