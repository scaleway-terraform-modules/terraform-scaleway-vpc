# Multi-Zones VPC Deployment Example

This example demonstrates how to deploy VPC resources across multiple Scaleway availability zones using the terraform-scaleway-vpc module.

## Overview

This configuration creates VPC infrastructure distributed across three availability zones (fr-par-1, fr-par-2, and fr-par-3) with dedicated public gateways for each zone. This example showcases the module's ability to handle multi-zone deployments using the new `zones` variable that replaced the single `zone` parameter.

## Architecture

- **Zone fr-par-1**: Public gateway with reserved IP and IPAM configuration
- **Zone fr-par-2**: Public gateway with reserved IP and IPAM configuration
- **Zone fr-par-3**: Public gateway with reserved IP and IPAM configuration
- **Shared VPC**: Single VPC with inter-zone routing enabled
- **Private Network**: Shared across all zones

## Key Features

### Zone-Aware Configuration

The example uses the `zones` variable to define deployment across multiple zones:

```hcl
module "vpc" {
  source = "../../"

  zones = ["fr-par-1", "fr-par-2", "fr-par-3"]
  # ... other configuration
}
```

### Dynamic Resource Creation

Resources are created dynamically for each specified zone using `for_each`:

- Public gateway IPs: One per zone when `gw_reserve_ip = true`
- IPAM IP allocations: One per zone for gateway network configuration
- Public gateways: One per zone with zone-specific naming
- Gateway networks: One per zone connecting to the shared private network

## Usage

Initialize Terraform:
```bash
terraform init
```

Plan the deployment:
```bash
terraform plan
```

Apply the configuration:
```bash
terraform apply
```

## Files

- `main.tf`: Main configuration with VPC module call and multi-zone setup
- `versions.tf`: Terraform and provider version constraints

This example validates that the module correctly handles multi-zone deployments and demonstrates best practices for zone-aware VPC infrastructure deployment on Scaleway.
