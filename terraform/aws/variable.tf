variable "region" {
  type        = string
  description = "AWS Region"
}

variable "profile" {
  type        = string
  description = "AWS Profile"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of the SSH key pair"
  default     = "appflowy"
}

variable "ssh_allowed_ipv6_cidr" {
  type        = string
  description = "IPv6 CIDR block to allow SSH access"
  default     = "::/0"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the ssh public key. Used by ansible to provision the VM"
}
