resource "tfe_variable" "iam_tags_environment" {
  key          = "tags_environment"
  value        = var.project_env[terraform.workspace]
  category     = "terraform"
  description  = "AWS Resource environment"
  workspace_id = tfe_workspace.iam_workspace.id
}