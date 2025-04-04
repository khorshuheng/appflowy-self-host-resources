variable "subscription_id" {
  type        = string
  description = "The ID of the Azure subscription"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
  default     = "appflowy"
}

variable "location" {
  type        = string
  description = "The location/region where the resource group will be created"
}

variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key for AppFlowy"
  default     = "appflowy-ssh-key"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
  default     = "appflowy"
}

variable "public_ip_name" {
  type        = string
  description = "The name of the public IP"
  default     = "appflowy"
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group"
  default     = "appflowy"
}

variable "ssh_allowed_source" {
  type        = string
  description = "The source IP address or CIDR block for SSH access"
  default     = "*"
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
  default     = "appflowy"
}

variable "network_interface_name" {
  type        = string
  description = "The name of the network interface"
  default     = "appflowy"
}

variable "vpn_client_address_space" {
  type        = string
  description = "The address space for the VPN client"
  default     = "172.16.201.0/24"
}

variable "tenant_id" {
  type        = string
  description = "Microsoft Azure tenant ID"
}
