resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/aws/ecs/${local.prefix}"
  retention_in_days = 30

  tags = "${local.common_tags}"
}

module "pipeline" {
  source       = "../../aws/ecs-svc-pipeline"

  pipe_webhook = "${var.pipe_webhook}"
  prefix       = "${local.prefix}-ci-pipe"
  common_tags  = "${local.common_tags}"
  kms_arn      = "${var.kms_arn}"

  # pipeline env
  gh_repo  = "${var.gh_repo}"
  gh_org   = "${var.gh_org}"
  gh_token = "${var.gh_token}"

  # network
  vpc_id             = "${var.vpc_id}"
  private_subnet_ids = "${var.private_subnet_ids}"

  # s3 buckets
  s3_artifacts     = "${var.s3_artifacts}"
  s3_cache         = "${var.s3_cache}"
  ecs_cluster_name = "${var.ecs["name"]}"
  ecs_service_name = "${aws_ecs_service.default.name}"
  buildspec            = "${data.template_file.buildspec.rendered}"
}

