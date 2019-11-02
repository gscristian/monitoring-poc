provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}

terraform {
  backend "s3" {
    region         = "eu-west-1"
    key            = "aws-ec2"
    bucket         = "tf-state-cgs"
    dynamodb_table = "tf-state-cgs-locks"
  }
}
