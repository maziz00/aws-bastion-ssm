terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.62.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-prod"
    key            = "bastion/terraform.tfstate"
    region         = "me-central-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
    profile        = "gprod"
  }
}

provider "aws" {
  region                   = "me-central-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "gprod"
}