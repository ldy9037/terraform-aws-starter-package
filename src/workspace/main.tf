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

resource "tfe_organization" "organization" {
  name  = var.tfc_org
  email = var.tfc_owner
}