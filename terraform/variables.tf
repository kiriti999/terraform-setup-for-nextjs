variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region"
}

variable "availability_zone" {
  type    = string
  default = "ap-south-1b"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "acm_ssl_arn" {
  type    = string
  default = "arn:aws:acm:ap-south-1:238369675568:certificate/df0ee229-f1bb-4c69-b989-c62e5e9f90ee"
}

variable "acm_ssl_arn_api" {
  type    = string
  default = "arn:aws:acm:ap-south-1:238369675568:certificate/df0ee229-f1bb-4c69-b989-c62e5e9f90ee"
}

variable "elb_health_target" {
  type    = string
  default = "HTTP:3000/api/health"
}

variable "env_name" {
  type = string
  default = "prod"
}
