variable "cluster_name" {
  type        = string
  description = "The name of the ECS Cluster, ECR Repository, and base naming prefix for associated resources."
}

variable "vpc_id" {
  type        = string
  description = "The target AWS VPC ID where your tasks and security groups will be deployed."
}

variable "alb_security_group_id" {
  type        = string
  description = "The upstream Application Load Balancer Security Group ID allowed to communicate with Fargate."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The explicit list of subnet IDs where the Fargate tasks will be provisioned."
}

variable "target_group_arn" {
  type        = string
  description = "The application target group ARN your ECS service binds targets against."
}

variable "fargate_cpu" {
  type        = string
  description = "Fargate vCPU specification allocation sizing limit for your tasks."
}

variable "fargate_memory" {
  type        = string
  description = "Fargate Memory allocation sizing limit for your tasks."
}

variable "container_name" {
  type        = string
  description = "The matching execution designation name identifier for the primary app runtime container container."
}

variable "app_port" {
  type        = number
  description = "The binding application port configuration matching the runtime stack exposure endpoint."
}

variable "desired_task_count" {
  type        = number
  description = "The explicit initial task instance count target threshold minimums for the service scheduler."
}

variable "assign_public_ip" {
  type        = bool
  description = "Toggle assignment execution logic allowing immediate allocation properties on network nodes."
}