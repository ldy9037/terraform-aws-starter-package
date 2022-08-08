variable "region" {
  description = "AWS Region"
  type        = string
}

variable "tags_iac" {
  description = "Resource에 어떤 IaC를 사용했는지"
  type        = string
}

variable "tags_owner" {
  description = "AWS Resource의 소유자"
  type        = string
}

variable "tags_team" {
  description = "어느 팀이 관리하고 있는지"
  type        = string
}

variable "tags_environment" {
  description = "AWS Resource 환경"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

# s3 for cloudtrail
variable "s3_bucket_acl" {
  description = "s3_bucket_acl"
  type        = string
  default     = "private"
}

variable "cloudtrail_s3_bucket" {
  description = "cloudtrail s3 bucket"
  type        = string
}

variable "server_side_encryption_configuration" {
  description = "server_side_encryption_configuration"
  type        = any
  default     = {}
}

variable "lifecycle_rule" {
  description = "lifecycle_rule"
  type        = any
  default     = []
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

# cloud trail
variable "cloudtrail_enabled" {
  description = "Boolean whether cloudtrail is enabled."
  type        = bool
  default     = true
}

variable "cloudtrail_name" {
  description = "The name of the trail."
  type        = string
  default     = "cloudtrail-multi-region"
}

variable "cloudtrail_cloudwatch_logs_enabled" {
  description = "Specifies whether the trail is delivered to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "cloudtrail_cloudwatch_logs_group_name" {
  description = "The name of CloudWatch Logs group to which CloudTrail events are delivered."
  type        = string
  default     = "cloudtrail-multi-region"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  type        = number
  default     = 365
}

variable "cloudtrail_iam_role_name" {
  description = "The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  type        = string
  default     = "CloudTrail-CloudWatch-Delivery-Role"
}

variable "cloudtrail_iam_role_policy_name" {
  description = "The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  type        = string
  default     = "CloudTrail-CloudWatch-Delivery-Policy"
}

variable "cloudtrail_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  type        = number
  default     = 10
}

variable "event_selector" {
  description = "Specifies an event selector for enabling data event logging."
  type = list(object({
    include_management_events = bool
    read_write_type           = string

    data_resource = list(object({
      type   = string
      values = list(string)
    }))
  }))
  default = []
}