# Availability zone
variable "aws_az" {
  type        = string
  description = "AWS AZ"
  default     = "ap-southeast-2a"
}

# Address range for vpc
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.1.64.0/18"
}

# Subnet variables
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
  default     = "10.1.64.0/24"
}
