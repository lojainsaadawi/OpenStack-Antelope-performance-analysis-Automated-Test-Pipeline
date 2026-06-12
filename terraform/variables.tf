variable "external_network" {
  description = "Name of the external network (for router gateway)"
  type        = string
}

variable "image_name" {
  description = "Name of the VM image to use"
  type        = string
}

variable "flavor_name" {
  description = "Flavor name for VMs"
  type        = string
}

variable "keypair_name" {
  description = "Name of the SSH keypair"
  type        = string
}

variable "network_prefix" {
  description = "Prefix for naming networks, subnets, router, etc."
  type        = string
}

variable "subnet1_cidr" {
  description = "CIDR for the first subnet (net1)"
  type        = string
  default     = "10.1.1.0/24"
}

variable "subnet1_gateway" {
  description = "Gateway IP for the first subnet"
  type        = string
  default     = "10.1.1.1"
}

variable "subnet1_allocation_start" {
  description = "Start of allocation pool for first subnet"
  type        = string
  default     = "10.1.1.10"
}

variable "subnet1_allocation_end" {
  description = "End of allocation pool for first subnet"
  type        = string
  default     = "10.1.1.50"
}

variable "subnet2_cidr" {
  description = "CIDR for the second subnet (net2)"
  type        = string
  default     = "10.1.2.0/24"
}

variable "subnet2_gateway" {
  description = "Gateway IP for the second subnet"
  type        = string
  default     = "10.1.2.1"
}

variable "subnet2_allocation_start" {
  description = "Start of allocation pool for second subnet"
  type        = string
  default     = "10.1.2.10"
}

variable "subnet2_allocation_end" {
  description = "End of allocation pool for second subnet"
  type        = string
  default     = "10.1.2.50"
}
