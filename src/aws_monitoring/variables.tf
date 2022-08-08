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