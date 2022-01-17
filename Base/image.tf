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

resource "ibm_is_instance" {
  name    = "terraform-test-instance"
  image   = "r010-28e8b4ba-6ab7-4af8-a01c-d9c38ccb3203"
  profile = "cx2-2x4"

  primary_network_interface {
    name   = "eth1"
    subnet = ibm_is_subnet.iac_test_subnet.id
    security_groups = [ ibm_is_security_group.iac_test_security_group.id ]
  }

  vpc  = ibm_is_vpc.iac_test_vpc.id
  zone = "eu-de-1"
  keys = []

  user_data = <<-EOUD
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOUD

  tags = [ "iac-terraform-test" ]
}

output "ip_address" {
  value = ibm_is_instance.iac_test_instance.primary_network_interface[0].primary_ipv4_address
}

resource "ibm_is_floating_ip" {
  name   = "terraform-test-ip"
  target = ibm_is_instance.iac_test_instance.primary_network_interface.0.id
  tags   = [ "iac-terraform-test" ]
}

resource "ibm_is_security_group" {
  name = "terraform-test-sg-public"
  vpc  = ibm_is_vpc.iac_test_vpc.id
}

resource "ibm_is_security_group_rule" {
  group     = ibm_is_security_group.iac_test_security_group.id
  direction = "inbound"
  tcp {
      port_min = 8080
      port_max = 8080
  }
}

output "ip_address_floating" {
  value = ibm_is_floating_ip.iac_test_floating_ip.address
}
