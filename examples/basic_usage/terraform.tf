terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "cisa-cool-terraform-state"
    dynamodb_table = "terraform-state-lock"
    region         = "us-east-1"
    profile        = "cool-user"
    role_arn       = "arn:aws:iam::608004238745:role/TerraformStateAccess"
    key            = "freeipa-master-tf-module/examples/basic_usage/terraform.tfstate"
  }
}
