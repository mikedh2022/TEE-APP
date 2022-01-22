variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}

# Github
variable "gh_repo" {}

variable "gh_org" {}
variable "gh_token" {}

# ECS
variable "ecs_cluster_name" {}

variable "ecs_service_name" {}

variable "s3_artifacts" {
  type = "map"
}

variable "s3_cache" {
  type = "map"
}

# network
variable "vpc_id" {}

variable "private_subnet_ids" {
  type = "list"
}

variable "pipe_webhook" {
  type = "map"
}

variable "buildspec" {}