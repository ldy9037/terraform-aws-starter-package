resource "tfe_variable" "monitoring_tags_environment" {
  key          = "tags_environment"
  value        = var.project_env[terraform.workspace]
  category     = "terraform"
  description  = "AWS Resource environment"
  workspace_id = tfe_workspace.monitoring_workspace.id
}