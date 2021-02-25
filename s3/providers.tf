// This defined the providers
// See https://www.terraform.io/docs/language/providers/requirements.html for more details
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
