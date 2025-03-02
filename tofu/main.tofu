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
  name    = "soerver"
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
  name    = "soerver"
  ttl     = 1800
  content = hcloud_server.main.ipv6_address
}
