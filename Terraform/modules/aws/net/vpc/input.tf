variable "prefix" {
  description = "prefix name"
}

variable "cidr_block" {
  description = "VPC CIDR Range"
}

variable "public_ranges" {
  description = "Public subnet IP ranges (comma separated)"
  type        = "list"
}

variable "private_ranges" {
  description = "Private subnet IP ranges (comma separated)"
  type        = "list"
}

variable "zones" {
  description = "AZs for subnets"
  type        = "map"

  default = {
    "us-east-1" = ["us-east-1a", "us-east-1c", "us-east-1d"]
  }
}

variable "domain_name_servers" {
  default = [
    "AmazonProvidedDNS",
    "8.8.8.8",
  ]

  type = "list"
}

variable "vpc_peers" {
  type = "map"

  default = {
    gw_id = ""
    cidr  = ""
  }

  description = "AWS VPN Peering (Peering VPC with other cloud providers or other VPCs *Support one gateway for now*)"
}

variable "common_tags" {
  default = {}
  type    = "map"
}

variable "vpc_tags" {
  default     = {}
  type        = "map"
  description = "Required to specify EKS tags for vpc for discovery services to work"
}

variable "subnet_tags" {
  default     = {}
  type        = "map"
  description = "Required to specify EKS tags for subnets for discovery services to work"
}
