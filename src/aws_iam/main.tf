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

locals {
  iam_group = {
    Administrator = {
      create_group = true
      user = [
        module.iam_user["ldy"].iam_user_name,
      ]
      policies = [
        "arn:aws:iam::aws:policy/AdministratorAccess"
      ] 
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

module "iam_group" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  for_each = local.iam_group

  name = each.key

  create_group = each.value["create_group"]

  custom_group_policy_arns = each.value["policies"]
  group_users              = each.value["user"]
}