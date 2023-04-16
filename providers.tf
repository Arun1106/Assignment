terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}
locals {
  timestamp = formatdate("YYYY-MM-DD", timestamp())
}