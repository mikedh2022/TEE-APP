variable "prefix" {}

variable "common_tags" {
  type = "map"
}

variable "s3_logging" {
  type = "map"
}

# network
variable "vpc_id" {}

variable "cidr_block" {}

variable "route_table_ids" {
  type = "list"
}

variable "kms_arn" {}

# network
variable "security_group_ids" {
  type = "map"
}

# Network
variable "net_ranges" {
  type        = "map"
  description = "Network ranges in map of lists"
}

variable "net_cidr" {
  description = "VPC CIDR Block"
}

variable "deletion_window_in_days" {
  default = 10
}
