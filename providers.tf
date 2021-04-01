# This is the "default" provider that is used to obtain the caller's
# credentials, which are used to set the session name when assuming
# roles in the other providers.
provider "aws" {
}

# The provider used to create IAM roles that can read selected SSM
# ParameterStore parameters in the Images account.
provider "aws" {
  alias = "provision_ssm_parameter_read_role"
}
