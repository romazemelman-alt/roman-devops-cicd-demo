variable "vpc_cidr" {
  type        = string
  description = "The primary IPv4 CIDR block allocation for the VPC (e.g., 10.0.0.0/16)."
}

variable "cluster_name" {
  type        = string
  description = "The base naming prefix used to tag the VPC, subnets, and routing infrastructure."
}