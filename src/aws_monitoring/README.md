## Table of Contents

- [소개](#소개)
- [시작하기](#시작하기)
- [주의사항](#주의사항)
- [참고](#참고)
- [제작자](#제작자)

## 소개

 AWS Starter Package 중 Monitoring/Logging/알림 등을 모아놓은 Directory
 
 ##### 기술 스택
 - terraform v1.1.7
 - [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
 
## 시작하기
### 초기 세팅
제일 먼저 Slack 알림을 위해 Chatbot Client를 구성합니다.
Chatbot Client는 [가이드](https://docs.aws.amazon.com/chatbot/latest/adminguide/getting-started.html#slack-setup)를 참고해서 4번까지만 진행해주시면 됩니다. 이 과정을 진행하면 client 세부 정보에 workspace id가 출력됩니다. 이 ID를 복사해뒀다가 아래 과정에서 필요할 때 붙여 넣어주시면 됩니다.

main.tf에서 아래 값을 변경해줍니다.
```sh
# main.tf
terraform {
  ...

  cloud {
    organization = "<AWS_ACCOUNT>"
    workspaces {
      name = "monitoring"
    }
  }

  required_version = ">= 1.1.7"
}

...
```
- AWS_ACCOUNT: 이메일 형식의 AWS root account에서 계정 부분  
(ex ldy9037@naver.com 에서 ldy9037) 

terraform.tfvars에서도 아래 값을 변경해줍니다.
```sh
# terraform.tfvars
cloudtrail_s3_bucket = "s3-cloudtrail-logs-management-<ORGANIZATION>"
s3_bucket_acl        = "private"
force_destroy        = true

...

sns_topic_enabled            = true
cloudwatch_sns_topic_name    = "CloudWatchAlarmsForCloudTrail"
sns_topic_subscription_email = ["<ALERT_EMAIL"]

...

chatbot_enabled              = true
slack_configuration_name     = "CloudWatchAlarmsForCloudTrail"
slack_channel_id             = "<SLACK_CHANNEL_ID>"
slack_workspace_id           = "<SLACK_WORKSPACE_ID>"
chatbot_logging_level        = "NONE"
chatbot_iam_role_name        = "AWS-Chatbot-NotificationsOnly"
chatbot_iam_role_policy_name = "AWS-Chatbot-NotificationsOnly-Policy"
...
```
- ORGANIZATION: 현재 계정의 조직/부서 명  
- ALERT_EMAIL: 알림에 사용될 Email
- SLACK_CHANNEL_ID: 알림 채널로 사용할 SLACK 채널의 ID
- SLACK_WORKSPACE_ID: 알림 채널로 사용할 Slack Workspace의 ID 

위 정보들을 설정했으면 Terraform을 초기화합니다.
```sh
terraform init
```

Terraform 구성 적용은 Terraform Cloud에서만 가능합니다. 로컬에서는 plan으로 구성 확인만 할 수 있습니다. 
```sh
terraform plan
```

## 주의사항
-

## 참고
- [Terraform aws Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 제작자
[ldy9037@naver.com](https://github.com/ldy9037)