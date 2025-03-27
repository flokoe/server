resource "hcloud_firewall" "main" {
  name = "main"

  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "udp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_ssh_key" "flokoe" {
  name       = "flokoe"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "hcloud_server" "main" {
  name               = "soerver.flokoe.de"
  server_type        = "cx22"
  image              = "debian-12"
  location           = "nbg1"
  ssh_keys           = [hcloud_ssh_key.flokoe.id]
  firewall_ids       = [hcloud_firewall.main.id]
  delete_protection  = true
  rebuild_protection = true
}

resource "hcloud_rdns" "main_ipv4" {
  server_id  = hcloud_server.main.id
  ip_address = hcloud_server.main.ipv4_address
  dns_ptr    = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "soerver_ipv4" {
  domain  = "flokoe.de"
  type    = "A"
  name    = "soerver.flokoe.de"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "hcloud_rdns" "server_ipv6" {
  server_id  = hcloud_server.main.id
  ip_address = hcloud_server.main.ipv6_address
  dns_ptr    = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "soerver_ipv6" {
  domain  = "flokoe.de"
  type    = "AAAA"
  name    = "soerver.flokoe.de"
  ttl     = 1800
  content = hcloud_server.main.ipv6_address
}

resource "inwx_nameserver_record" "citizen_alpha" {
  domain  = "citizen-alpha.de"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "citizen_alpha_wildcard" {
  domain  = "citizen-alpha.de"
  type    = "CNAME"
  name    = "*.citizen-alpha.de"
  ttl     = 1800
  content = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "citizen_alpha_eu" {
  domain  = "citizen-alpha.eu"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "citizen_alpha_eu_wildcard" {
  domain  = "citizen-alpha.eu"
  type    = "CNAME"
  name    = "*.citizen-alpha.eu"
  ttl     = 1800
  content = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "citizen_alpha_org" {
  domain  = "citizen-alpha.org"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "citizen_alpha_org_wildcard" {
  domain  = "citizen-alpha.org"
  type    = "CNAME"
  name    = "*.citizen-alpha.org"
  ttl     = 1800
  content = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "citizenalpha_eu" {
  domain  = "citizenalpha.eu"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "citizenalpha_eu_wildcard" {
  domain  = "citizenalpha.eu"
  type    = "CNAME"
  name    = "*.citizenalpha.eu"
  ttl     = 1800
  content = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "citizenalpha_org" {
  domain  = "citizenalpha.org"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "citizenalpha_org_wildcard" {
  domain  = "citizenalpha.org"
  type    = "CNAME"
  name    = "*.citizenalpha.org"
  ttl     = 1800
  content = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "citizenalpha" {
  domain  = "citizenalpha.de"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "citizenalpha_wildcard" {
  domain  = "citizenalpha.de"
  type    = "CNAME"
  name    = "*.citizenalpha.de"
  ttl     = 1800
  content = "soerver.flokoe.de"
}

resource "inwx_nameserver_record" "flokoe_ipv4" {
  domain  = "flokoe.de"
  type    = "A"
  ttl     = 1800
  content = hcloud_server.main.ipv4_address
}

resource "inwx_nameserver_record" "flokoe_ipv6" {
  domain  = "flokoe.de"
  type    = "AAAA"
  ttl     = 1800
  content = hcloud_server.main.ipv6_address
}

resource "inwx_nameserver_record" "www_flokoe" {
  domain  = "flokoe.de"
  type    = "CNAME"
  name    = "www.flokoe.de"
  ttl     = 1800
  content = "flokoe.de"
}
