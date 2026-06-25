aws_region   = "eu-north-1"
cluster_name = "my-devops-cicd-roma"
vpc_cidr     = "10.0.0.0/16"

# vpc_id                = "vpc-0123456789abcdef0"         # Replace with your real VPC ID
# alb_security_group_id = "sg-0123456789abcdef0"         # Replace with your real ALB SG ID
# private_subnet_ids    = ["subnet-11111111", "subnet-22222222"] # Replace with your real subnet IDs
target_group_arn      = "arn:aws:elasticloadbalancing:eu-north-1:128353492351:targetgroup/my-devops-cicd-demo-tg/12345678" # Replace with your real TG ARN

# Extracted Hardcoded Configuration Settings
fargate_cpu        = "256"
fargate_memory     = "512"
container_name     = "hello-world-app"
app_port           = 8080
desired_task_count = 1
assign_public_ip   = true

public_port           = 80
health_check_path     = "/"
health_check_timeout  = 5
health_check_interval = 30
healthy_threshold     = 3
unhealthy_threshold   = 3