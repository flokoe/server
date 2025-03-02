terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50.0"
    }

    inwx = {
      source  = "inwx/inwx"
      version = "~> 1.6.0"
    }
  }
}
