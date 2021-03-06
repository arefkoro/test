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

resource "ibm_is_vpc" "ibm_is_vpc" {
  name = "terraform-test-vpc"
}

module "ibm_is_subnet" "ibm_is_subnet" {
  source = "../"
}
