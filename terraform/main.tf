terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket       = "sushmitha-voting-tfstate-20260710"
    key          = "multi-stack-voting/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
