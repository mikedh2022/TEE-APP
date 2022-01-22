resource "aws_codebuild_project" "build" {
  name          = "${local.prefix}-build"
  description   = "${local.prefix} "
  build_timeout = "${var.build_timeout}"
  service_role  = "${module.role_codebuild.arn}"

  source {
    type      = "GITHUB"
    location  = "${data.template_file.codebuild_source_location.rendered}"
    buildspec = "${var.buildspec}"

    auth {
      type     = "OAUTH"
      resource = "${var.github_oauth_token}"
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "${var.compute_type}"
    image           = "${var.image}"
    type            = "${var.type}"
    privileged_mode = "${var.privileged_mode}"

    environment_variable = ["${var.environment_variables}"]
  }

  vpc_config {
    vpc_id = "${var.vpc_id}"

    subnets = ["${var.private_subnet_ids}"]

    security_group_ids = ["${aws_security_group.codebuild.id}"]
  }

  tags = "${local.common_tags}"
}

data "template_file" "codebuild_source_location" {
  template = "https://github.com/$${owner}/$${repository}.git"

  vars {
    owner      = "${var.github_owner}"
    repository = "${var.gh_repo}"
  }
}
