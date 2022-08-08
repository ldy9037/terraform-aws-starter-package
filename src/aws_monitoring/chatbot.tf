data "aws_iam_policy_document" "chatbot_assume_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "chatbot_cloudwatch" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled && var.chatbot_enabled ? 1 : 0

  name_prefix        = var.chatbot_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.chatbot_assume_policy.json
}

data "aws_iam_policy_document" "chatbot_cloudwatch_policy" {
  statement {
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "chatbot_cloudwatch_policy" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled && var.chatbot_enabled ? 1 : 0

  name_prefix = var.chatbot_iam_role_policy_name
  path        = "/"
  policy      = data.aws_iam_policy_document.chatbot_cloudwatch_policy.json
}

resource "aws_iam_role_policy_attachment" "chatbot_cloudwatch_policy" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled && var.chatbot_enabled ? 1 : 0

  role       = aws_iam_role.chatbot_cloudwatch[0].id
  policy_arn = aws_iam_policy.chatbot_cloudwatch_policy[0].arn
}


module "chatbot_slack_configuration" {
  count = var.cloudtrail_enabled && var.sns_topic_enabled && var.chatbot_enabled ? 1 : 0

  source  = "waveaccounting/chatbot-slack-configuration/aws"
  version = "1.1.0"

  configuration_name = var.slack_configuration_name
  iam_role_arn       = aws_iam_role.chatbot_cloudwatch[0].arn
  logging_level      = var.chatbot_logging_level
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id

  sns_topic_arns = [
    aws_sns_topic.cloudwatch_alarms_for_cloudtrail[0].arn,
  ]
}