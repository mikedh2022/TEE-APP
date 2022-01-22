variable "name" {
  description = "S3 Bucket Name"
}

variable "acl" {
  description = "Policy ACL"
  default     = "private"
}

variable "policy_id" {
  description = "Bucket policy ID"
  default     = "PutObjPolicy"
}

variable "common_tags" {
  type = "map"
}

variable "logging_bucket" {}
