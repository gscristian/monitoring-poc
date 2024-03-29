provider "aws" {
  region  = "eu-west-1"
  profile = "terraform"
}

terraform {
  backend "s3" {
    region         = "eu-west-1"
    key            = "aws-network"
    bucket         = "tf-state-cgs"
    dynamodb_table = "tf-state-cgs-locks"
  }
}