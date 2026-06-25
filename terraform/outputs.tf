output "ecr_repository_url" {
  description = "The URL of the ECR repository to push images to"
  value       = module.ecs_fargate.ecr_repository_url
}

output "alb_dns_name" {
  description = "Public URL to access the deployed application"
  value       = module.alb.alb_dns_name
}