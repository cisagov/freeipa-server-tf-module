# The provider used to create IAM roles that can read selected SSM
# ParameterStore parameters in the Images account.
provider "aws" {
  alias = "provision_ssm_parameter_read_role"
}
