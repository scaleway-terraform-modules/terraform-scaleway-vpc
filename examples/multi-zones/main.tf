module "vpc" {
  source = "../../"

  name   = "multi-zone-example"
  region = "fr-par"
  zones  = ["fr-par-1", "fr-par-2", "fr-par-3"]

  gw_enabled     = true
  enable_routing = true

  bastion_enabled    = true
  bastion_port       = 22
  masquerade_enabled = true
  smtp_enabled       = false

  tags = ["multi-zone", "example", "terraform"]
}
