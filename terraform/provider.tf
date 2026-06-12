terraform {
  required_version = ">= 0.12"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.54.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "openstack" {
  auth_url = "http://10.20.0.2:5000/v3"
}
