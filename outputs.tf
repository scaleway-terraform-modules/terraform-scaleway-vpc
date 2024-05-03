output "gw_flexible_ip_address" {
  description = "Address of gateway flexible IP."
  value       = try(scaleway_vpc_public_gateway_ip.this[0].address, null)
}

output "gw_flexible_ip_id" {
  description = "ID of gateway flexible IP."
  value       = try(scaleway_vpc_public_gateway_ip.this[0].id, null)
}

output "gw_id" {
  description = "ID of public gateways."
  value       = try(scaleway_vpc_public_gateway.this[0].id, null)
}

output "ip4_cidr" {
  description = "CIDR of the IPv4 subnet associated to the Private Network."
  value       = scaleway_vpc_private_network.this.ipv4_subnet[0].subnet
}

output "ip6_cidr" {
  description = "CIDR of the IPv6 subnet associated to the Private Network."
  value       = coalescelist(scaleway_vpc_private_network.this.ipv6_subnets[*].subnet)
}

output "pn_id" {
  description = "ID of private networks."
  value       = scaleway_vpc_private_network.this.id
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = scaleway_vpc.this.id
}
