terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 3.28.0"
    }
  }
  required_version = ">= 0.14.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "periscopai"

    workspaces {
      name = "vivaterra-data-storage-example"
    }
  }
}
