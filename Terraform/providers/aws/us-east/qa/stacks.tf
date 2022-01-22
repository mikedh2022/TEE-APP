module "common" {
  source                     = "../../../../modules/stacks/common-env"

  prefix                     = "${local.prefix}"
  common_tags                = "${local.common_tags}"
  s3_logging                 = "${module.common.s3_logging}"

  vpc_id     = "${module.common.vpc["vpc_id"]}"
  cidr_block = "${module.common.vpc["cidr_block"]}"

  route_table_ids = [
    "${module.common.private_route_table_ids}",
    "${module.common.public_route_table_ids}",
  ]

  security_group_ids = {
    default_vpc    = "${module.common.default_sg_id}"
  }
  kms_arn              = "${module.common.kms_arn}"
  net_cidr    = "${var.net_cidr}"
  net_ranges  = "${var.net_ranges}"

}


module "hello-service" {
  source      = "../../../../modules/stacks/hello-service"
  prefix      = "${local.prefix}"
  common_tags = "${local.common_tags}"

  fargate_cpu    = "1024"
  fargate_memory = "2048"
  desired_count  = "3"

  vpc_id             = "${module.common.vpc["vpc_id"]}"
  public_subnet_ids  = "${module.common.public_subnet_ids}"
  private_subnet_ids = "${module.common.private_subnet_ids}"

  # cluser
  ecs = "${module.common.ecs}"

  # security & audit
  kms_arn = "${module.common.kms_arn}"

  # gh
  gh_token   = "${data.terraform_remote_state.github.token}"
  gh_org     = "${data.terraform_remote_state.github.organization}"
  gh_repo    = "${data.terraform_remote_state.github.repo["hello_world"]}"

  # s3
  s3_artifacts       = "${module.common.s3_artifacts}"
  s3_logging         = "${module.common.s3_logging}"
  s3_cache           = "${module.common.s3_codebuild_cache}"

  pipe_webhook = "${merge(
    map("match_equals", "refs/heads/master"),
    map("json_path", "$.ref"),
    map("secret", "${var.webhook_secret}")
  )}"
}
