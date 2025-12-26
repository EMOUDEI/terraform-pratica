# state.tf
terraform {
  backend "s3" {
    bucket  = "deivid-terraform"
    key     = "site/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

  }
}
