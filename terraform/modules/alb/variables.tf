variable "cluster_name" {
  type        = string
  description = "The naming prefix used for the ALB, target group, and security group."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the ALB security group and target group will be created."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of public subnet IDs where the internet-facing ALB will be provisioned."
}

# --- New Parameterized Variables ---
variable "public_port" {
  type        = number
  description = "The public-facing port the ALB listens on (e.g., 80 for HTTP)."
}

variable "app_port" {
  type        = number
  description = "The backend container port where traffic is forwarded (e.g., 8080)."
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