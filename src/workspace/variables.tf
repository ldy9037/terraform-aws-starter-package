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