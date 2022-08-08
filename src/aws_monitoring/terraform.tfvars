# s3 for cloudtrail
cloudtrail_s3_bucket = "s3-cloudtrail-logs-management-<ORGANIZATION>"
s3_bucket_acl        = "private"
force_destroy        = true

server_side_encryption_configuration = {
  rule = {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default = {
      sse_algorithm = "AES256"
    }
  }
}

lifecycle_rule = [
  {
    id = "rule-1"

    transition = [
      {
        days          = 180
        storage_class = "STANDARD_IA"
      }
    ]

    expiration = [
      {
        days = 365
      }
    ]

    filter = {}

    status = "Enabled"
  }
]

# cloudtrail
cloudtrail_enabled                     = true