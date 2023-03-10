resource "scaleway_vpc_private_network" "this" {
  name = format("%s-network", var.name)
  tags = var.tags
  zone = var.zone
}

resource "scaleway_vpc_public_gateway_ip" "this" {
  count = var.gw_enabled && var.gw_reserve_ip ? 1 : 0

  tags = var.tags
  zone = var.zone
}

resource "scaleway_vpc_public_gateway" "this" {
  count = var.gw_enabled ? 1 : 0

  bastion_enabled      = var.bastion_enabled
  bastion_port         = var.bastion_port
  enable_smtp          = var.smtp_enabled
  ip_id                = var.gw_reserve_ip ? scaleway_vpc_public_gateway_ip.this[count.index].id : null
  name                 = format("%s-gateway", var.name)
  tags                 = var.tags
  type                 = var.gw_type
  upstream_dns_servers = var.dns_servers
  zone                 = var.zone
}

resource "scaleway_vpc_public_gateway_dhcp" "this" {
  count = var.gw_enabled ? 1 : 0

  subnet = var.subnet
  zone   = var.zone
}

resource "scaleway_vpc_gateway_network" "this" {
  count = var.gw_enabled ? 1 : 0

  dhcp_id            = scaleway_vpc_public_gateway_dhcp.this[count.index].id
  enable_dhcp        = var.dhcp_enabled
  enable_masquerade  = var.masquerade_enabled
  gateway_id         = scaleway_vpc_public_gateway.this[count.index].id
  private_network_id = scaleway_vpc_private_network.this.id
  zone               = var.zone
}
