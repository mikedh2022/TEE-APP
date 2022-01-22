data "template_file" "buildspec" {
  template = "${file("${path.module}/templates/buildspec.yml")}"
}

module "build" {
  source      = "../../../aws/ci-build"
  prefix      = "${local.prefix}"
  common_tags = "${var.common_tags}"
  kms_arn     = "${var.kms_arn}"

  gh_repo           = "${var.gh_repo}"

  # network
  vpc_id             = "${var.vpc_id}"
  private_subnet_ids = "${var.private_subnet_ids}"

  # codebuild
  source_location = "${local.prefix}/source.zip"
  buildspec       = "${data.template_file.buildspec.rendered}"
  build_timeout   = "15"
  github_oauth_token = "${var.gh_oauth_token}"
  github_owner = "${var.gh_org}"

}
