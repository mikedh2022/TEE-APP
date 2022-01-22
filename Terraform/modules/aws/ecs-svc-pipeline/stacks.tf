module "codebuild" {
  source         = "../ecs-pipeline-build/"
  prefix         = "${local.prefix}-build"
  common_tags    = "${var.common_tags}"
  kms_arn        = "${var.kms_arn}"

  # network
  vpc_id             = "${var.vpc_id}"
  private_subnet_ids = "${var.private_subnet_ids}"

  # s3 buckets
  s3_artifacts = "${var.s3_artifacts}"

  # codebuild
  buildspec  = "${var.buildspec}"
  s3_cache   = "${var.s3_cache}"

}
