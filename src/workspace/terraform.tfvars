tfc_org   = "<AWS_ACCOUNT>"
tfc_owner = "<USER_EMAIL>"

tfc_defualt_team_name = "owners"
tfc_membership = [
]

github_username   = "<GITHUB_USERNAME>"
github_repository = "<GITHUB_REPOSITORY>"
github_branch = {
  default = "main"
  dev     = "develop"
}

workspace_name = {
  iam     = "iam"
}

workspace_working_directory = {
  iam     = "aws_iam"
}

notification_configuration_destination_type = "slack"
notification_configuration_enabled          = true
notification_configuration_triggers         = ["run:created", "run:planning", "run:completed", "run:errored"]