# s3 buckets
output "s3_codebuild_cache" {
  value = {
    id     = "${aws_s3_bucket.codebuild_cache.id}"
    arn    = "${aws_s3_bucket.codebuild_cache.arn}"
    bucket = "${aws_s3_bucket.codebuild_cache.bucket}"
  }
}

output "s3_artifacts" {
  value = {
    id     = "${aws_s3_bucket.artifacts.id}"
    arn    = "${aws_s3_bucket.artifacts.arn}"
    bucket = "${aws_s3_bucket.artifacts.bucket}"
  }
}

# ecs
output "ecs" {
  value = {
    name = "${aws_ecs_cluster.default.name}"
    arn  = "${aws_ecs_cluster.default.arn}"
  }
}

output "s3_logging" {
  value = {
    arn         = "${module.s3_logging.arn}"
    id          = "${module.s3_logging.id}"
    aws_address = "${module.s3_logging.aws_address}"
  }
}

output "kms_arn" {
  value = "${aws_kms_key.a.arn}"
}

output "vpc" {
  value = {
    cidr_block = "${module.network.vpc["cidr_block"]}"
    vpc_id     = "${module.network.vpc["vpc_id"]}"
  }
}

output "private_subnet_ids" {
  value = "${module.network.private_subnet_ids}"
}

output "public_subnet_ids" {
  value = "${module.network.public_subnet_ids}"
}

output "private_route_table_ids" {
  value = "${module.network.private_route_table_ids}"
}

output "public_route_table_ids" {
  value = "${module.network.public_route_table_ids}"
}

output "default_sg_id" {
  value = "${module.network.default_sg_id}"
}