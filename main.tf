resource "scaleway_vpc" "this" {
  name = format("%s-vpc", var.name)

  enable_routing = var.enable_routing
  project_id     = var.project_id
  region         = var.region
  tags           = var.tags
}

resource "scaleway_vpc_private_network" "this" {
  name       = format("%s-network", var.name)
  project_id = var.project_id
  region     = var.region
  vpc_id     = scaleway_vpc.this.id
  tags       = var.tags

  dynamic "ipv4_subnet" {
    for_each = var.ipv4_subnet != null ? [1] : []

    content {
      subnet = var.ipv4_subnet
    }
  }

  dynamic "ipv6_subnets" {
    for_each = var.ipv6_subnet != null ? [1] : []

    content {
      subnet = var.ipv6_subnet
    }
  }
}

resource "scaleway_vpc_public_gateway_ip" "this" {
  for_each = var.gw_enabled && var.gw_reserve_ip ? toset(compact(var.zones)) : []

  project_id = var.project_id
  tags       = var.tags
  zone       = each.value
}

resource "scaleway_ipam_ip" "this" {
  for_each = var.gw_enabled ? toset(compact(var.zones)) : []

  is_ipv6    = false
  region     = var.region
  project_id = var.project_id

  source {
    private_network_id = scaleway_vpc_private_network.this.id
  }

  tags = var.tags
}

resource "scaleway_vpc_public_gateway" "this" {
  for_each = var.gw_enabled ? toset(compact(var.zones)) : []

  allowed_ip_ranges = var.allowed_ip_ranges
  bastion_enabled   = var.bastion_enabled
  bastion_port      = var.bastion_port
  enable_smtp       = var.smtp_enabled
  ip_id             = var.gw_reserve_ip ? scaleway_vpc_public_gateway_ip.this[each.value].id : var.ip_id
  name              = format("%s-gateway-%s", var.name, each.value)
  project_id        = var.project_id
  refresh_ssh_keys  = var.refresh_ssh_keys
  tags              = var.tags
  type              = var.gw_type
  zone              = each.value
}

resource "scaleway_vpc_gateway_network" "this" {
  for_each = var.gw_enabled ? toset(compact(var.zones)) : []

  enable_masquerade  = var.masquerade_enabled
  gateway_id         = scaleway_vpc_public_gateway.this[each.value].id
  private_network_id = scaleway_vpc_private_network.this.id
  zone               = each.value

  ipam_config {
    push_default_route = true
    ipam_ip_id         = scaleway_ipam_ip.this[each.value].id
  }
}
