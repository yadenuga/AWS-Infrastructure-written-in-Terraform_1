# Code for the provider
provider "aws" {
    region = "us-east-1"
    profile = "terraform-yemi"
  
}
# Storage of terraform codes in the S3
terraform {
  backend "s3" {
    bucket = "terraform-bucket-yemi"
    key = "terraform.tfstate.dev"
    region = "us-east-1"
    profile = "terraform-yemi"
    
  }
}