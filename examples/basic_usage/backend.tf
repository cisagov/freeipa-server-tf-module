terraform {
  backend "s3" {
    bucket         = "cisa-cool-terraform-state"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    key            = "freeipa-master-tf-module/examples/basic_usage/terraform.tfstate"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
  }
}
