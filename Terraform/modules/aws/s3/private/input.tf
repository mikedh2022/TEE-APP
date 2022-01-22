variable "name" {
  description = "S3 Bucket Name"
}

variable "acl" {
  description = "Policy ACL"
  default     = "private"
}

variable "common_tags" {
  type = "map"
}

variable "logging_bucket" {}
