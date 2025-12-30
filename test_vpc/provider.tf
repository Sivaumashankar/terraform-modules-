terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "terrafrom-99"
    key    = "vpc-test"
    region = "us-east-1"
    dynamodb_table = "umashankar"
    
  }
}

 


provider "aws" {
  # Configuration options
  region = "us-east-1"
}