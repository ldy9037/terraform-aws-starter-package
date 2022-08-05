terraform {
  required_providers {
    tfe = "~> 0.30.2"
  }
  
  required_version = ">= 1.1.7"

  backend "s3" {
  }
}

provider "tfe" {
}

data "tfe_team" "owners" {
  name         = var.tfc_defualt_team_name
  organization = tfe_organization.organization.id
}

resource "tfe_organization" "organization" {
  name  = var.tfc_org
  email = var.tfc_owner
}

resource "tfe_organization_membership" "organization_membership" {
  count = length(var.tfc_membership)

  organization = tfe_organization.organization.id
  email        = var.tfc_membership[count.index]
}

resource "tfe_team_organization_member" "team_organization_member" {
  count = length(tfe_organization_membership.organization_membership)

  team_id                    = data.tfe_team.owners.id
  organization_membership_id = tfe_organization_membership.organization_membership[count.index].id
}