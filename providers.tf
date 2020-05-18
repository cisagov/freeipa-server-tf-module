# The "default" provider that is used to do everything _but_ create
# public DNS entries
provider "aws" {
}

# The provider that is used to create public DNS entries
provider "aws" {
  alias = "public_dns"
}
