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

output "pn_id" {
  description = "ID of private networks."
  value       = scaleway_vpc_private_network.this.id
}


output "vpc_id" {
  description = "ID of the VPC."
  value       = scaleway_vpc.this.id
}
