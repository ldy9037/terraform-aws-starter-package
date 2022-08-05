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