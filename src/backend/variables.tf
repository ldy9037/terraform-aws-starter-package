variable "organization" {
  description = "Organization 명"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "dynamodb_tfstate_lock_table_name" {
  description = "Dynamodb table 명"
  type        = string
}

variable "dynamodb_tfstate_lock_table_billing_mode" {
  description = "Dynamodb table의 읽기 및 쓰기에 대한 결제 방식"
  type        = string
}

variable "dynamodb_tfstate_lock_table_read_capacity" {
  description = "Dynamodb table의 읽기 용량"
  type        = number
}

variable "dynamodb_tfstate_lock_table_write_capacity" {
  description = "Dynamodb table의 쓰기 용량"
  type        = number
}

variable "dynamodb_tfstate_lock_table_hash_key" {
  description = "Dynamodb table의 hash key"
  type        = string
}

variable "dynamodb_tfstate_lock_table_attributes" {
  description = "Dynamodb table의 attributes"
  type = list(object({
    name = string
    type = string
  }))
}

variable "s3_log_bucket_name" {
  description = "Log용 S3 Bucket 명"
  type        = string
}

variable "s3_log_bucket_acl" {
  description = "Log용 S3 Bucket ACL"
  type        = string
}

variable "s3_tfstate_bucket_name" {
  description = "State용 S3 Bucket 명"
  type        = string
}

variable "s3_tfstate_bucket_acl" {
  description = "State용 S3 Bucket의 ACL"
  type        = string
}

variable "s3_tfstate_bucket_force_destroy" {
  description = "S3 Bucket에 객체가 존재해도 bucket을 삭제 할 지 여부"
  type        = string
}

variable "s3_tfstate_bucket_logging_target_prefix" {
  description = "S3 Bucket의 모든 로그 객체 키 접두사"
  type        = string
}

variable "s3_tfstate_bucket_logging_versioning_status" {
  description = "S3 Bucket 객체의 Versioning 여부"
  type        = string
}