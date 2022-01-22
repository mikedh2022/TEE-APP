data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  prefix      = "${var.prefix}-country"
  common_tags = "${merge(var.common_tags, map("stack", "default"))}"

  # build steps
  build_step_project_name = "${local.prefix}"

  dimensions_map = {
    "TargetGroup"  = "${aws_alb_target_group.default.arn_suffix}"
    "LoadBalancer" = "${aws_alb.default.arn_suffix}"
  }
}

//data "aws_ecs_task_definition" "default" {
//  task_definition = "${aws_ecs_task_definition.default.family}"
//}

data "template_file" "buildspec" {
  template = "${file("${path.module}/templates/buildspec.yml")}"

  vars {
    IMAGE_TAG = "${var.common_tags["env"]}"
    REPOSITORY_URI = "${aws_ecr_repository.default.repository_url}"
  }
}
