# The provider that is used to create DNS entries
provider "aws" {
  alias = "dns"
}

# The "default" provider that is used to do everything else
provider "aws" {
}
