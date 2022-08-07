## Table of Contents

- [소개](#소개)
- [시작하기](#시작하기)
- [주의사항](#주의사항)
- [참고](#참고)
- [제작자](#제작자)

## 소개

 AWS Template 중 Terraform Cloud의 Workspace 설정에 대한 directory
 이 directory에서 Terraform workspace를 통해 resource들을 적절하게 그룹화하고 환경별로 나눌 수 있습니다.
 
 ##### 기술 스택
 - terraform v1.1.7
 - [tfe provider](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)
 
## 시작하기

### 초기 실행
먼저 AWS 계정을 관리하고 있는 담당자에게 액세스 키를 전달 받아야 합니다. 액세스 키는 Access Key ID와 Secret Access Key로 구성되어 있습니다. 지금은 액세스 키를 Variable Set으로 전체 공유하고 있지만 리소스 그룹 별로 관리 조직이 다를 경우 Variable Set 대신 최소 권한을 가진 여러 IAM으로 나눠 각 Terraform Cloud Workspace에 전달할 수 있습니다. 그리고 각 액세스 키는 해당 workspace에서 관리할 Resource들에 대한 권한을 보유하고 있어야 합니다. 

기본 설정되어 있는 알림은 Slack입니다. 여기서 설정하는 알림은 Terraform Cloud Workspace에 작업 시 트리거되는 알림입니다. 
만약 Slack 말고 다른 알림 채널을 사용하고 싶으시면 [여기](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration)서 가능한 알림 채널 중 하나를 선택해 구성할 수 있습니다.

만약 알림 채널로 slack을 그대로 사용하겠다 하면 아래 문서를 참고해 Slack Webhook URL을 생성합니다.  
- [Slack Webhook 생성 가이드](https://harmonious-lan-9d2.notion.site/Slack-API-App-Webhook-db30f7ce0d514f4583d955808372f17e)

이 알림 설정도 모든 workspace에서 같은 slack 채널을 공유하도록 설정되어 있습니다. 만약 workspace 별로 다른 slack 채널로 알림을 전송하고 싶다면 각 채널 별로 webhook URL 생성 후 각각 resource를 생성해 terraform cloud workspace와 연결해주시면 됩니다. 

위 설정들이 끝났으면 실행에 필요한 환경 변수를 지정합니다. 여기서 지정한 환경변수는 Terraform 변수로도 사용됩니다.    
[direnv](https://harmonious-lan-9d2.notion.site/direnv-89499a72674348ad893c79e87cf2a878)를 사용하면 매번 변수를 export 하지않아도 됩니다. 
```sh
# s3 backend 설정
export TF_VAR_region=ap-northeast-2 

export TF_VAR_organization=<ORGANIZATION>
export TF_VAR_s3_tfstate_bucket_name=s3-tfstate-management-$TF_VAR_organization
export TF_VAR_s3_tfstate_bucket_encryt=true
export TF_VAR_s3_tfstate_bucket_acl=private
export TF_VAR_s3_tfstate_bucket_key=workspace/terraform.tfstate
export TF_VAR_dynamodb_tfstate_lock_table_name=TerraformStateLock

# AWS 인증 정보 
export TF_VAR_aws_access_key=<AWS_ACCESS_KEY_ID>
export TF_VAR_aws_secret_access_key=<AWS_SECRET_ACCESS_KEY>

# Slack Webhook URL
export TF_VAR_slack_webhook_url=<SLACK_WEBHOOK_URL>
```
- ORGANIZATION: backend에서 설정했던 값과 똑같이 작성해줍니다. 
- AWS_ACCESS_KEY_ID: 위에서 전달 받은 Access Key ID
- AWS_SECRET_ACCESS_KEY: 위에서 전달 받은 Secret Access Key
- SLACK_WEBHOOK_URL: 위에서 설정한 Slack Webhook URL


그리고 terraform.tfvars에서 일부 변수들을 지정해 줍니다.
```sh
# terraform.tfvars
tfc_org   = "<AWS_ACCOUNT>"
tfc_owner = "<USER_EMAIL>"
tfc_membership = [
]

...

github_username   = "<GITHUB_USERNAME>"
github_repository = "<GITHUB_REPOSITORY>"
github_branch = {
  default = "main"
  dev     = "develop"
}

...

aws_account_id = "<AWS_ACCOUNT_NUM>"

...

tags_iac  = "terraform"
tags_team = "<TEAM_NAME>"
...
```
- AWS_ACCOUNT: 이메일 형식의 AWS root account에서 계정 부분  
(ex ldy9037@naver.com 에서 ldy9037)  
- USER_EMAIL: Terraform Cloud 관리자 지정
- GITHUB_REPOSITORY: Github Repository 명
- AWS_ACCOUNT_ID: 숫자 형식의 AWS account ID  
(ex 91239423223)
- tags_team: 본인이 속한 팀 이름  
(ex DevOps Team, Backend Team) 

만약 Terraform Cloud상에 다른 사용자도 추가해놓고 싶다면 tfc_membership 하위에 사용자의 이메일을 입력해줍니다. tfc_owner는 제외해주세요.
```sh
# ex
tfc_membership = [
  "test1@google.com",
  "test2@naver.com",
  "test3@daum.net",
  ...
]
```

위 설정이 끝났다면 Terraform을 초기화하면서 Backend를 설정해줍니다. 

```sh
terraform init \
-backend-config="bucket=$TF_VAR_s3_tfstate_bucket_name" \
-backend-config="key=$TF_VAR_s3_tfstate_bucket_key" \
-backend-config="region=$TF_VAR_region" \
-backend-config="encrypt=$TF_VAR_s3_tfstate_bucket_encryt" \
-backend-config="acl=$TF_VAR_s3_tfstate_bucket_acl" \
-backend-config="dynamodb_table=$TF_VAR_dynamodb_tfstate_lock_table_name"
```

이제 구성을 적용합니다. 하지만 OAuth 설정을 해야하기 때문에 Organization만 생성해줍니다.
```sh
terraform apply -target=tfe_organization.organization
```

organization이 생성됐다면 [가이드](https://www.terraform.io/cloud-docs/vcs/github)를 보고 Github와 연동합니다. 진행자가 Github 내 팀 repository들에 대한 Webhook 권한을 가지고 있어야 합니다. 만약 없다면 해당 권한이 있는 사용자에게 위 작업을 요청해주세요.

VCS 연동이 되었다면 연동 작업 중에 Terraform app을 설치하고 받은 OAuth Token ID를 환경 변수 OAUTH_TOKEN_ID로 지정해줍니다. 
OAuth Token ID는 Organization > Settings > Providers에서 확인 할 수 있습니다.
```sh
# OAuth Oauth ID
export TF_VAR_oauth_token_id=<OAUTH_TOKEN_ID>
```

이제 Terraform을 반영합니다.
```sh
$ terraform apply
```

## 주의사항
- backend에서 설정했던 organization과 terraform cloud organization은 같은 값이 아닙니다. 조직 구성에 맞게 지정해주세요.
- terraform cloud workspace와 terraform workspace는 다른 개념입니다. terraform cloud workspace는 terraform cloud 상에서의 작업 공간이고 terraform workspace는 terraform state에 대한 작업 공간입니다. github의 branch 개념과 비슷합니다. 

## 참고
- [Terraform tfe Provider](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)
- [Terraform Backend Type: S3](https://www.terraform.io/language/settings/backends/s3)
- [Terraform State 정리](https://harmonious-lan-9d2.notion.site/Terraform-State-79a2e5707e944055a07b3386da9b6491)
- [Terraform Cloud VCS 연동](https://www.terraform.io/cloud-docs/vcs/github)

## 제작자
[ldy9037@naver.com](https://github.com/ldy9037)
