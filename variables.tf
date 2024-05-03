variable "bastion_enabled" {
  description = "Enable SSH bastion on gateways."
  type        = bool
  default     = false
}

variable "bastion_port" {
  description = "Port on which SSH bastions will listen."
  type        = number
  default     = 61000
}

variable "dns_servers" {
  description = "Override the gateway's default recursive DNS servers."
  type        = list(string)
  default     = null
}

variable "gw_enabled" {
  description = "Create a public gateway and attach it to the subnet."
  type        = bool
  default     = true
}

variable "gw_reserve_ip" {
  description = "Reserve a flexible IP for the gateway."
  type        = bool
  default     = true
}

variable "gw_type" {
  description = "Gateway type. Can be `VPC-GW-S` or `VPC-GW-M"
  type        = string
  default     = "VPC-GW-S"
}

variable "ipv4_subnet" {
  description = "IPv4 subnet to associate with the private network."
  type        = string
  default     = null
}

variable "ipv6_subnet" {
  description = "IPv6 subnet to associate with the private network."
  type        = string
  default     = null
}

variable "masquerade_enabled" {
  description = "Enable masquerade on these networks."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the private network & gateway. If not provided it will be randomly generated."
  type        = string
  default     = null
}

variable "project_id" {
  description = "ID of the project in which ressources should be created."
  type        = string
  default     = null
}

variable "region" {
  description = "Zone in which ressources should be created."
  type        = string
  default     = null
}

variable "smtp_enabled" {
  description = "Enable SMTP on gateways."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags associated with ressources."
  type        = list(string)
  default     = []
}

variable "zone" {
  description = "Zone in which ressources should be created."
  type        = string
  default     = null
}
