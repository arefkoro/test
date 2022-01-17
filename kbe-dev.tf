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

module "ibm_is_vpc" {
  source = "git::https://github.com/arefkoro/test"
}

module "ibm_is_instance" {
  source = "git::https://github.com/arefkoro/test"
}
