terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
  # region = var.region
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}
