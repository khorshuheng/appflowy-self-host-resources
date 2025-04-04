variable "subscription_id" {
  type        = string
  description = "The ID of the Azure subscription"
}

variable "automation_account_name" {
  type        = string
  description = "The name of the automation account"
}

variable "docker_hub_password" {
  type        = string
  description = "Docker Hub token to access AppFlowy Premium Image"
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

variable "ssh_allowed_source" {
  type        = string
  description = "The source IP address or CIDR block for SSH access"
  default     = "*"
}

variable "domain_name_label" {
  type        = string
  description = "The domain name label for the AppFlowy Cloud public IP"
}

variable "smtp_host" {
  type        = string
  description = "The SMTP host for sending emails"
}

variable "smtp_port" {
  type        = number
  description = "The SMTP port for sending emails"
  default     = 465
}

variable "smtp_user" {
  type        = string
  description = "The SMTP user for sending emails"
}

variable "smtp_password" {
  type        = string
  description = "The SMTP password for sending emails"
}

variable "smtp_email" {
  type        = string
  description = "The email address to use as the sender"
}

variable "smtp_tls_kind" {
  type        = string
  description = "The type of TLS to use for SMTP (none, wrapper, required or opportunistic)"
  default     = "required"
}

variable "azure_open_ai_endpoint" {
  type        = string
  description = "Azure Open AI endpoint"
}

variable "azure_open_ai_key" {
  type        = string
  description = "Azure Open AI API Key"
}

variable "azure_open_ai_version" {
  type        = string
  description = "Azure Open AI version"
}
