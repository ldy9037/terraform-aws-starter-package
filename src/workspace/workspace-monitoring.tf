resource "tfe_workspace" "monitoring_workspace" {
  name              = var.workspace_name["monitoring"]
  organization      = tfe_organization.organization.id
  terraform_version = var.tfc_terraform_version
  working_directory = var.workspace_working_directory["monitoring"]

  vcs_repo {
    identifier     = "${var.github_username}/${var.github_repository}"
    branch         = var.github_branch["default"]
    oauth_token_id = var.oauth_token_id
  }
}

resource "tfe_notification_configuration" "monitoring_notification_configuration" {
  name             = "${tfe_organization.organization.name}-${tfe_workspace.monitoring_workspace.name}"
  destination_type = var.notification_configuration_destination_type
  enabled          = var.notification_configuration_enabled
  triggers         = var.notification_configuration_triggers
  url              = var.slack_webhook_url
  workspace_id     = tfe_workspace.monitoring_workspace.id
}