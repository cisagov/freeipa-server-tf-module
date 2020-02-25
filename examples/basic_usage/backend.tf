terraform {
  backend "s3" {
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
    key            = "freeipa-master-tf-module/examples/basic_usage/terraform.tfstate"
    profile        = "cool-terraform-backend"
    region         = "us-east-1"
  }
}
