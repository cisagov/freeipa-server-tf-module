# The provider that is used to create public DNS entries
provider "aws" {
  alias = "public_dns"
}

# The "default" provider that is used to do everything else
provider "aws" {
}
