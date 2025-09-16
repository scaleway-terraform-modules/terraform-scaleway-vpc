# Terraform / Scaleway

## Purpose

This repository is used to manage VPCs on scaleway using terraform.

## Usage

- Setup the [scaleway provider](https://www.terraform.io/docs/providers/scaleway/index.html) in your tf file.
- Include this module in your tf file. Refer to [documentation](https://www.terraform.io/docs/modules/sources.html#generic-git-repository).

```hcl
module "my_network" {
  source  = "scaleway-terraform-modules/vpc/scaleway"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement_scaleway) | >= 2.52.0 |

## Resources

| Name | Type |
|------|------|
| [scaleway_ipam_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/ipam_ip) | resource |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc) | resource |
| [scaleway_vpc_gateway_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_gateway_network) | resource |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_private_network) | resource |
| [scaleway_vpc_public_gateway.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway) | resource |
| [scaleway_vpc_public_gateway_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_enabled"></a> [bastion_enabled](#input_bastion_enabled) | Enable SSH bastion on gateways. | `bool` | `false` | no |
| <a name="input_bastion_port"></a> [bastion_port](#input_bastion_port) | Port on which SSH bastions will listen. | `number` | `61000` | no |
| <a name="input_enable_routing"></a> [enable_routing](#input_enable_routing) | Enable routing between Private Networks in the VPC. Note that you will not be able to deactivate it afterwards. | `bool` | `false` | no |
| <a name="input_gw_enabled"></a> [gw_enabled](#input_gw_enabled) | Create a public gateway and attach it to the subnet. | `bool` | `true` | no |
| <a name="input_gw_reserve_ip"></a> [gw_reserve_ip](#input_gw_reserve_ip) | Reserve a flexible IP for the gateway. | `bool` | `true` | no |
| <a name="input_gw_type"></a> [gw_type](#input_gw_type) | Gateway type. Can be `VPC-GW-S` or `VPC-GW-M` | `string` | `"VPC-GW-S"` | no |
| <a name="input_ipv4_subnet"></a> [ipv4_subnet](#input_ipv4_subnet) | IPv4 subnet to associate with the private network. If null, a free /22 will be used. | `string` | `null` | no |
| <a name="input_ipv6_subnet"></a> [ipv6_subnet](#input_ipv6_subnet) | IPv6 subnet to associate with the private network. If null, a free /64 will be used. | `string` | `null` | no |
| <a name="input_masquerade_enabled"></a> [masquerade_enabled](#input_masquerade_enabled) | Enable masquerade on these networks. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input_name) | Name of the private network & gateway. If not provided it will be randomly generated. | `string` | `null` | no |
| <a name="input_project_id"></a> [project_id](#input_project_id) | ID of the project in which ressources should be created. Defaults to provider project. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input_region) | Zone in which ressources should be created. Defaults to provider region. | `string` | `null` | no |
| <a name="input_smtp_enabled"></a> [smtp_enabled](#input_smtp_enabled) | Enable SMTP on gateways. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Tags associated with ressources. | `list(string)` | `[]` | no |
| <a name="input_zones"></a> [zones](#input_zones) | Zones in which ressources should be created. Defaults to provider zone. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gw_flexible_ip_address"></a> [gw_flexible_ip_address](#output_gw_flexible_ip_address) | Address of gateway flexible IP. |
| <a name="output_gw_flexible_ip_id"></a> [gw_flexible_ip_id](#output_gw_flexible_ip_id) | ID of gateway flexible IP. |
| <a name="output_gw_id"></a> [gw_id](#output_gw_id) | ID of public gateways. |
| <a name="output_ip4_cidr"></a> [ip4_cidr](#output_ip4_cidr) | CIDR of the IPv4 subnet associated to the Private Network. |
| <a name="output_ip6_cidr"></a> [ip6_cidr](#output_ip6_cidr) | CIDR of the IPv6 subnet associated to the Private Network. |
| <a name="output_pn_id"></a> [pn_id](#output_pn_id) | ID of private networks. |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id) | ID of the VPC. |
<!-- END_TF_DOCS -->

## Authors

Module is maintained with help from [the community](https://github.com/scaleway-terraform-modules/terraform-scaleway-vpc/graphs/contributors).

## License

Mozilla Public License 2.0 Licensed. See [LICENSE](https://github.com/scaleway-terraform-modules/terraform-scaleway-vpc/tree/master/LICENSE) for full details.
