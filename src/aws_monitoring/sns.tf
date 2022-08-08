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