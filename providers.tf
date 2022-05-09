provider "github" {
  token = var.GITHUB_TOKEN
}

provider "aws" {
  region     = var.region
  version    = "~> 3.0"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  cloud {
    organization = "tugrul"

    workspaces {
      name = "cv-iac"
    }
  }
}
