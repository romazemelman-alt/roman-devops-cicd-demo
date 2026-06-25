output "target_group_arn" {
  value       = aws_lb_target_group.app.arn
  description = "The ARN of the target group for the ECS service configuration mapping."
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The security group ID of the ALB to pass to the ECS task firewall rules."
}

output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The public URL of your load balancer to test your live app endpoint."
}