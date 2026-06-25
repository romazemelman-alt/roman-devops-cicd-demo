variable "aws_region" {
  type        = string
  description = "Target AWS Region"
}

variable "cluster_name" {
  type        = string
  description = "Resource prefix and cluster name"
}

variable "vpc_cidr" {
  type        = string
  description = "The base CIDR block for the custom VPC"
}