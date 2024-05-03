resource "scaleway_vpc" "this" {
  name       = format("%s-vpc", var.name)
  project_id = var.project_id
  region     = var.region
  tags       = var.tags
}

resource "scaleway_vpc_private_network" "this" {
  name       = format("%s-network", var.name)
  project_id = var.project_id
  region     = var.region
  vpc_id     = scaleway_vpc.this.id
  tags       = var.tags

  dynamic "ipv4_subnet" {
    for_each = var.subnet != null ? [1] : []

    content {
      subnet = var.subnet
    }
  }
}

resource "scaleway_vpc_public_gateway_ip" "this" {
  count = var.gw_enabled && var.gw_reserve_ip ? 1 : 0

  project_id = var.project_id
  tags       = var.tags
  zone       = var.zone
}

resource "scaleway_ipam_ip" "this" {
  count = var.gw_enabled ? 1 : 0

  is_ipv6    = false
  region     = var.region
  project_id = var.project_id

  source {
    private_network_id = scaleway_vpc_private_network.this.id
  }
}

resource "scaleway_vpc_public_gateway" "this" {
  count = var.gw_enabled ? 1 : 0

  bastion_enabled      = var.bastion_enabled
  bastion_port         = var.bastion_port
  enable_smtp          = var.smtp_enabled
  ip_id                = var.gw_reserve_ip ? scaleway_vpc_public_gateway_ip.this[count.index].id : null
  name                 = format("%s-gateway", var.name)
  project_id           = var.project_id
  tags                 = var.tags
  type                 = var.gw_type
  upstream_dns_servers = var.dns_servers
  zone                 = var.zone
}

resource "scaleway_vpc_gateway_network" "this" {
  count = var.gw_enabled ? 1 : 0

  enable_masquerade  = var.masquerade_enabled
  gateway_id         = scaleway_vpc_public_gateway.this[count.index].id
  private_network_id = scaleway_vpc_private_network.this.id
  zone               = var.zone

  ipam_config {
    push_default_route = true
    ipam_ip_id         = scaleway_ipam_ip.this[count.index].id
  }
}
