provider "aws" {
  region = "us-west-2"
}

provider "aws" {
  alias  = "global_east"
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.9.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.64.0"
    }
  }

  backend "s3" {
    bucket = "eaportfolio-terraform-state-bucket"
    key    = "stage/terraform.tfstate"
    region = "us-west-2"
  }
}
