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
cloudtrail_name                        = "management-event-trail"
cloudtrail_cloudwatch_logs_enabled     = true
cloudtrail_cloudwatch_logs_group_name  = "cloudtrail-multi-region"
cloudwatch_logs_retention_in_days      = "180"
cloudtrail_iam_role_name               = "CloudTrail-CloudWatch-Delivery-Role"
cloudtrail_iam_role_policy_name        = "CloudTrail-CloudWatch-Delivery-Policy"
cloudtrail_key_deletion_window_in_days = 10
event_selector = [{
  read_write_type           = "All"
  include_management_events = true

  data_resource = []
  }
]

# sns
sns_topic_enabled            = true
cloudwatch_sns_topic_name    = "CloudWatchAlarmsForCloudTrail"
sns_topic_subscription_email = ["<ALERT_EMAIL"]

# chatbot
chatbot_enabled              = true