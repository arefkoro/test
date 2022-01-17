terraform {
  required_version = ">= 0.13.3"
  required_providers {
    ibm = {
      source  = "ibm-cloud/ibm"
      version = "1.12.0"
    }
  }
}

provider "ibm" {
  generation         = 2
  region             = "eu-de"
}

resource "ibm_is_subnet" {
  name                      = "terraform-test-subnet"
  vpc                       = ibm_is_vpc.iac_test_vpc.id
  zone                      = "eu-de-1"
  total_ipv4_address_count  = 256
}
