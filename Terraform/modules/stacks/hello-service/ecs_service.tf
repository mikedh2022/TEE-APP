resource "aws_ecs_service" "default" {
  name            = "${local.prefix}-service"
  cluster         = "${var.ecs["name"]}"
  task_definition = "${aws_ecs_task_definition.default.arn}"
  desired_count   = "${var.desired_count}"
  launch_type     = "FARGATE"

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    security_groups = [
      "${aws_security_group.default.id}",
    ]

    subnets = [
      "${var.private_subnet_ids}",
    ]
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.default.id}"
    container_name   = "app"
    container_port   = "${var.port}"
  }

  depends_on = [
    "aws_alb_listener.default",
  ]

  lifecycle = {
    ignore_changes = ["task_definition", "desired_count"]
  }
}
