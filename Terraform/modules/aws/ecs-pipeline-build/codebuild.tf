resource "aws_codebuild_project" "build" {
  name          = "${local.prefix}"
  description   = "${local.prefix} sources from pipeline"
  build_timeout = "${var.build_timeout}"
  service_role  = "${module.role_codebuild.arn}"

  source {
    type      = "CODEPIPELINE"
    buildspec = "${var.buildspec}"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "${var.compute_type}"
    image           = "${var.image}"
    type            = "${var.type}"
    privileged_mode = "${var.privileged_mode}"
  }

  vpc_config {
    vpc_id = "${var.vpc_id}"

    subnets = ["${var.private_subnet_ids}"]

    security_group_ids = ["${aws_security_group.codebuild.id}"]
  }

  tags = "${local.common_tags}"
}
