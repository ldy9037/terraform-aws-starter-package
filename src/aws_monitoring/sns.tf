locals {
  sns_topic_arn = var.cloudtrail_enabled && var.sns_topic_enabled ? aws_sns_topic.cloudwatch_alarms_for_cloudtrail[0].arn : ""
}

data "aws_iam_policy_document" "alarms_sns_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws_account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${local.sns_topic_arn}",
    ]

    sid = "__default_statement_ID"
  }
}

resource "aws_sns_topic" "cloudwatch_alarms_for_cloudtrail" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled ? 1 : 0

  name = var.cloudwatch_sns_topic_name
}

resource "aws_sns_topic_subscription" "email" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled ? length(var.sns_topic_subscription_email) : 0

  topic_arn = aws_sns_topic.cloudwatch_alarms_for_cloudtrail[0].arn
  protocol  = "email"
  endpoint  = var.sns_topic_subscription_email[count.index]
}

resource "aws_sns_topic_subscription" "slack" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled && var.chatbot_enabled ? 1 : 0

  topic_arn = aws_sns_topic.cloudwatch_alarms_for_cloudtrail[0].arn
  protocol  = "https"
  endpoint  = "https://global.sns-api.chatbot.amazonaws.com"
}

resource "aws_sns_topic_policy" "alarms" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled ? 1 : 0

  arn    = aws_sns_topic.cloudwatch_alarms_for_cloudtrail[0].arn
  policy = data.aws_iam_policy_document.alarms_sns_policy.json
}