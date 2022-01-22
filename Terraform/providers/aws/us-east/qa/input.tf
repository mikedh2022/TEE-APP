
variable "env" {
  default = "qa"
}

variable "project_name" {
  default = "test"
}

variable "region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "obytes"
}

#===================#
#   Network         #
#===================#
variable "net_cidr" {
  description = "VPC CIDR Block"
}

variable "net_ranges" {
  type = "map"

  description = <<EOF
  Accepts a list e.g:

    network = {
      private_cidr_ranges = ""
      public_cidr_ranges = ""
    }

EOF
}

variable "webhook_secret" {
  description = "A shared secret between GitHub and AWS that allows AWS codePipeline to authenticate the request came from GitHub"
}
