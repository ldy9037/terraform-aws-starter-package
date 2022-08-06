variable "region" {
  description = "AWS Region"
  type        = string
}

variable "tfc_org" {
  description = "Teraform Cloud Organization 이름"
  type        = string
}

variable "tfc_owner" {
  description = "Terraform Cloud Organization 소유자"
  type        = string
}

variable "tfc_defualt_team_name" {
  description = "Terraform Cloud 기본 생성 팀"
  type        = string
}

variable "tfc_membership" {
  description = "Terraform Cloud 사용자"
  type        = list(string)
}

variable "workspace_name" {
  description = "Terraform Cloud Workspace 이름"
  type        = map(any)
}

variable "tfc_terraform_version" {
  description = "Terraform Cloud에서 사용할 Terraform version"
  type        = string
}

variable "workspace_working_directory" {
  description = "Terraform Cloud working directory"
  type        = map(any)
}

variable "github_username" {
  description = "Github username"
  type        = string
}

variable "github_repository" {
  description = "Github Repository 명"
  type        = string
}

variable "github_branch" {
  description = "Github branch"
  type        = map(any)
}

variable "oauth_token_id" {
  description = "Oauth Token ID"
  type = string
  sensitive = true
  default = "token"
}

variable "notification_configuration_destination_type" {
  description = "알림 채널"
  type        = string
}

variable "notification_configuration_enabled" {
  description = "알림 사용 여부"
  type        = bool
}

variable "notification_configuration_triggers" {
  description = "어떤 이벤트에 trigger 할 것인지"
  type        = list(string)
}

variable "slack_webhook_url" {
  description = "Slack Webhook URL"
  type        = string
}

variable "project_env" {
  description = "프로젝트 환경"
  type        = map(string)
}

variable "tags_iac" {
  description = "Resource에 어떤 IaC를 사용했는지"
  type        = string
}

variable "tags_team" {
  description = "어느 팀이 관리하고 있는지"
  type        = string
}