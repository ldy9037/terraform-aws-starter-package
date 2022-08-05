dynamodb_tfstate_lock_table_billing_mode   = "PROVISIONED"
dynamodb_tfstate_lock_table_read_capacity  = 5
dynamodb_tfstate_lock_table_write_capacity = 5
dynamodb_tfstate_lock_table_hash_key       = "LockID"
dynamodb_tfstate_lock_table_attributes = [{
  name = "LockID"
  type = "S"
}]