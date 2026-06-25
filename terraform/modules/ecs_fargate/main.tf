# Container Registry
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_ecr_repository" "repo" {
  name                 = var.cluster_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

# ECS Execution Role (To pull image from ECR and stream logs)
resource "aws_iam_role" "ecs_execution" {
  name = "${var.cluster_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = var.cluster_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([{
    name      = var.container_name
    image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.ecr_repository_name}:latest"
    essential = true
    portMappings = [{
      containerPort = var.app_port
      hostPort      = var.app_port
    }]
  }])
}

# Network Security: Allow traffic from ALB ONLY
resource "aws_security_group" "ecs_tasks" {
  name   = "${var.cluster_name}-tasks-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Fargate Service
resource "aws_ecs_service" "main" {
  name            = "${var.cluster_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_task_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.app_port
  }
}