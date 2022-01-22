variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}

# s3 buckets
variable "s3_cache" {
  type = "map"
}

variable "s3_artifacts" {
  type = "map"
}

# codebuild
variable "buildspec" {}

variable "build_timeout" {
  default = 5
}

variable "compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  default = "aws/codebuild/docker:17.09.0"
}

variable "type" {
  default = "LINUX_CONTAINER"
}

variable "privileged_mode" {
  default = true
}

# network
variable "vpc_id" {}

variable "private_subnet_ids" {
  type = "list"
}

# cloudwatch
variable "retention_in_days" {
  default = 30
}
