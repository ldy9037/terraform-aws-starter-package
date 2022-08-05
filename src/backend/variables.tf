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