terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  # Lets `terraform validate` and plan-free tooling run without credentials.
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}
