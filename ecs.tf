resource "aws_ecs_cluster" "sourcefuse_cluster" {
  name = "sourcefuse-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
resource "aws_ecs_task_definition" "nginx_task" {
  family                = "sourcefuse-nginx-task"
  cpu                   = "256"
  memory                = "512"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn    = aws_iam_role.ecs_role.arn
  task_role_arn         = aws_iam_role.ecs_role.arn

  container_definitions = <<DEFINITION
  [
    {
      "name": "nginx",
      "image": "nginx",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
}
resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.sourcefuse_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.sourcefuse_public_subnet_1.id, aws_subnet.sourcefuse_public_subnet_2.id]
    security_groups = [aws_security_group.sourcefuse_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_tg.arn
    container_name   = "nginx"
    container_port   = 80
  }
}
