terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "roman-devops-terraform-state-bucket"
    key     = "state/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Network Layer
module "vpc" {
  source       = "./modules/vpc"
  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
}

# 2. Routing & Load Balancing Layer
# (Moved above ECS because ECS depends on its target_group_arn and security group)
module "alb" {
  source                = "./modules/alb"
  cluster_name          = var.cluster_name
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  public_port           = var.public_port
  app_port              = var.app_port
  health_check_path     = var.health_check_path
  health_check_timeout  = var.health_check_timeout
  health_check_interval = var.health_check_interval
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
}

# 3. Compute & Container Registry Layer
module "ecs_fargate" {
  source = "./modules/ecs_fargate"
  cluster_name = var.cluster_name

  # EXCLUSIVELY USING MODULE OUTPUTS HERE (No longer using root vars)
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id # <-- FIXED THIS LINE

  app_port           = var.app_port
  assign_public_ip   = var.assign_public_ip
  container_name     = var.container_name
  desired_task_count = var.desired_task_count
  fargate_cpu        = var.fargate_cpu
  fargate_memory     = var.fargate_memory
}