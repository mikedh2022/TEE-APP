variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}

variable "gh_repo" {}

# codebuild
variable "source_location" {
  default = ""
}

variable "buildspec" {}

variable "environment_variables" {
  type    = "list"
  default = []
}

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

# cloudwatch
variable "retention_in_days" {
  default = 30
}

# network
variable "vpc_id" {}

variable "private_subnet_ids" {
  type = "list"
}

variable "github_oauth_token" {}
variable "github_owner" {}
