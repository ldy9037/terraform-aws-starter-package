data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AWSCloudTrailAclCheck20220808"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      module.s3_bucket.s3_bucket_arn
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite20220808"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${module.s3_bucket.s3_bucket_arn}/AWSLogs/${var.aws_account_id}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }

}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.1.1"

  create_bucket = var.cloudtrail_enabled ? true : false

  bucket = var.cloudtrail_s3_bucket

  force_destroy = var.force_destroy
  acl           = var.s3_bucket_acl

  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  server_side_encryption_configuration = var.server_side_encryption_configuration

  lifecycle_rule = var.lifecycle_rule
}