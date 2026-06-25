variable "aws_region" {
  type        = string
  description = "Target AWS Region"
}

variable "vpc_cidr" {
  type        = string
  description = "The base CIDR block for the custom VPC"
}

variable "cluster_name" {
  type        = string
  description = "The name of the ECS Cluster, ECR Repository, and base naming prefix for associated resources."
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

variable "public_port" {
  type        = number
  description = "The public-facing port the ALB listens on (e.g., 80 for HTTP)."
}

variable "health_check_path" {
  type        = string
  description = "The destination path for the target group health check request."
}

variable "health_check_timeout" {
  type        = number
  description = "The amount of time, in seconds, during which no response means a failed health check."
}

variable "health_check_interval" {
  type        = number
  description = "The approximate amount of time, in seconds, between health checks of an individual target."
}

variable "healthy_threshold" {
  type        = number
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
}

variable "unhealthy_threshold" {
  type        = number
  description = "The number of consecutive health check failures required before considering a target unhealthy."
}