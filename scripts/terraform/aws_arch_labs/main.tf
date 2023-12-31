terraform {
  backend "s3" {
    bucket         = "mirasa-terraform-remote-state-1"
    key            = "TF_STATE_FILE/aws_arch_labs_state_file"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "Terraform-backend-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

