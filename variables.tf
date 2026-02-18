variable "instance_type" {
  type        = string
  description = "Ec2 instance config"
}

variable "key_name" {
  type        = string
  description = "Key For ec2 auth"
}

variable "pub_key_path" {
  type        = string
  description = "path to my pub key for auth"
}

variable "azs" {
  type        = number
  description = "Availability Zones For Svc"
}

variable "cidr_blocks" {
  type        = string
  description = "cidr_blocks for network config"
}

variable "vpc_cidr" {
  type        = string
  description = "cidr for custom vpc "
}

variable "default_region" {
  type        = string
  description = "var for region"
}

variable "environment" {
  type        = string
  description = "var to define environment "
}

variable "project_name" {
  type        = string
  description = "var for project name"
}

variable "s3_bucket_name" {
  type        = string
  description = "s3 bucket name"
}

variable "my_home_ip" {
  type        = string
  description = "My home IP for Bastion SSH"
}