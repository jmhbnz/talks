variable "linux_instance_type" {
  type        = string
  description = "EC2 instance type for server"
  default     = "t2.micro"
}

variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate a public ip address to the ec2 instance"
  default     = true
}

variable "linux_root_volume_size" {
  type        = number
  description = "Volume size of root volume of server"
}

variable "linux_data_volume_size" {
  type        = number
  description = "Volume size of data volume of server"
}

variable "linux_root_volume_type" {
  type        = string
  description = "Volume type of root volume of server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "linux_data_volume_type" {
  type        = string
  description = "Volume type of data volume of server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}
