terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }

  required_version = ">= 1.1.7"
}

provider "aws" {
  region = var.region
}

module "dynamodb_tf_lock_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "1.2.2"

  name           = var.dynamodb_tfstate_lock_table_name
  billing_mode   = var.dynamodb_tfstate_lock_table_billing_mode
  read_capacity  = var.dynamodb_tfstate_lock_table_read_capacity
  write_capacity = var.dynamodb_tfstate_lock_table_write_capacity
  hash_key       = var.dynamodb_tfstate_lock_table_hash_key

  attributes = var.dynamodb_tfstate_lock_table_attributes
}

module "s3_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.1.1"

  bucket = "${var.s3_log_bucket_name}-${var.organization}"
  acl    = var.s3_log_bucket_acl
}

module "s3_tfstate_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.1.1"

  bucket = var.s3_tfstate_bucket_name
  acl    = var.s3_tfstate_bucket_acl

  force_destroy = var.s3_tfstate_bucket_force_destroy

  logging = {
    target_bucket = module.s3_log_bucket.s3_bucket_id
    target_prefix = var.s3_tfstate_bucket_logging_target_prefix
  }

  versioning = {
    status = var.s3_tfstate_bucket_logging_versioning_status
  }
}