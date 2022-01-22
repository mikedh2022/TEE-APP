terraform {
  backend "s3" {
    bucket                  = "terraform"
    key                     = "aws/us-east-1/test1/github/terraform.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "obytes"
  }

  required_version = "= 0.11.13"
}

provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
  version = "~> 1.3.0"
}
