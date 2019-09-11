# The "default" provider
provider "aws" {
}

# The provider for configuring public DNS
provider "aws" {
  alias = "public_dns"
}
