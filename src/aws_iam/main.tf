terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }

  cloud {
    organization = "<AWS_ACCOUNT>"
    workspaces {
      name = "iam"
    }
  }

  required_version = ">= 1.1.7"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.tags_environment
      IAC         = var.tags_iac
      Team        = var.tags_team
      Owner       = var.tags_owner
    }
  }
}

resource "aws_iam_account_alias" "alias" {
  account_alias = var.iam_account_alias
}

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.1.0"

  for_each = var.iam_user

  name = each.key

  create_iam_access_key         = each.value["iam_user_create_iam_access_key"]
  create_iam_user_login_profile = each.value["iam_user_create_login_profile"]
}

