variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}


variable "ecs" {
  type = "map"
}

# gh
variable "gh_token" {}

variable "gh_repo" {}
variable "gh_org" {
  default = ""
}

variable "s3_logging" {
  type = "map"
}

variable "s3_artifacts" {
  type = "map"
}

variable "s3_cache" {
  type = "map"
}

# ecs fargate
variable "fargate_cpu" {
  default = 256
}

variable "fargate_memory" {
  default = 512
}

variable "desired_count" {
  default = 1
}

variable "port" {
  default = 8080
}

# network
variable "public_subnet_ids" {
  type = "list"
}

variable "private_subnet_ids" {
  type = "list"
}

variable "vpc_id" {}

variable "pipe_webhook" {
  type = "map"
}
