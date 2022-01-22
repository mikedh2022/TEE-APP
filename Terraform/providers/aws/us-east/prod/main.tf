terraform {
  backend "s3" {
    bucket                  = "terraform"
    key                     = "aws/us-east1/prod/terraform.tfstate"
    region                  = "us-west-2"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "obytes"
  }

  required_version = "= 0.11.10"
}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.aws_profile}"
  version = "~> 1.41.0"
}

provider "template" {
  version = "~> 1.0.0"
}

provider "github" {
  version      = "< 1.3.0"
  organization = "${data.terraform_remote_state.github.organization}"
  token        = "${data.terraform_remote_state.github.token}"
}

# data
data "aws_region" "current" {}

data "terraform_remote_state" "github" {
  backend = "s3"

  config {
    bucket                  = "terraform"
    key                     = "github/terraform.tfstate"
    region                  = "us-west-2"
    profile                 = "obytes"
    shared_credentials_file = "~/.aws/credentials"
  }
}

# variables/locals
locals {
  prefix      = "${var.env}-${replace(data.aws_region.current.name, "-", "")}"

  common_tags = {
    env          = "${var.env}"
    project_name = "${var.project_name}"
    region       = "${data.aws_region.current.name}"
  }
}
