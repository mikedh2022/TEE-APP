variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "kms_arn" {}

variable "gh_repo" {}
variable "gh_org" {}

# network
variable "vpc_id" {}

variable "private_subnet_ids" {
  type = "list"
}

variable "gh_oauth_token" {}