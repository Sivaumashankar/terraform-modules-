terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "uma-security-group"
    key    = "test-sg-group"
    region = "us-east-1"
    dynamodb_table = "security-group"
    
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"
}