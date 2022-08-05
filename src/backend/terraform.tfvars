dynamodb_tfstate_lock_table_billing_mode   = "PROVISIONED"
dynamodb_tfstate_lock_table_read_capacity  = 5
dynamodb_tfstate_lock_table_write_capacity = 5
dynamodb_tfstate_lock_table_hash_key       = "LockID"
dynamodb_tfstate_lock_table_attributes = [{
  name = "LockID"
  type = "S"
}]

s3_log_bucket_name = "s3-tfstate-log-management-<ORGANIZATION>"
s3_log_bucket_acl  = "log-delivery-write"

s3_tfstate_bucket_force_destroy             = "false"
s3_tfstate_bucket_logging_target_prefix     = "tfstate/"
s3_tfstate_bucket_logging_versioning_status = "false"