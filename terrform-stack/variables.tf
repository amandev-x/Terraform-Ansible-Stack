variable "Main_VPC" {
  type        = string
  description = "VPC name"
  default     = ""
}

variable "Main_VPC-cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = ""
}

variable "public_subnet" {
  type        = string
  description = "public subnet cidr block"
  default     = ""
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "public subnet cidr block"
  default     = ""
}
variable "public_RTB" {
  type        = string
  description = "public route table name"
  default     = ""
}

variable "main_IGW" {
  type        = string
  description = "Main IGW name"
  default     = ""
}

variable "ec2_instance" {
  type        = string
  description = "Ubuntu ec2 instance name"
  default     = ""
}

variable "http_inbound" {
  type        = string
  description = "http ingress rule name"
  default     = ""
}

variable "https_inbound" {
  type        = string
  description = "https ingress rule name"
  default     = ""
}

variable "http_outbound" {
  type        = string
  description = "HTTP outbound rule"
  default     = ""
}

variable "https_outbound" {
  type        = string
  description = "HTTPS outbound rule"
  default     = ""
}

variable "dns_outbound" {
  type        = string
  description = "DNS outbound rule"
  default     = ""
}

variable "secure_ip_address_ssh_inbound" {
  type        = string
  description = "Secure known ip address for accessing EC2 instance through SSH"
  default     = ""
}

