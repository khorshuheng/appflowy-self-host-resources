variable "project" {
  type        = string
  description = "GCP Project"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "zone" {
  type        = string
  description = "GCP Zone"
}

variable "name" {
  type        = string
  description = "Name for the google compute instance"
  default     = "appflowy-cloud"
}

variable "machine_type" {
  type        = string
  description = "Machine type for google compute instance"
  default     = "e2-micro"
}

variable "network" {
  type        = string
  description = "VPC network for the kubernetes cluster"
}

variable "subnetwork" {
  type        = string
  description = "VPC subnetwork for the kubernetes cluster"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the google compute instance"
  default     = ["http-server", "https-server"]
}

variable "disk_size" {
  type        = number
  description = "Disk size for the google compute instance, in Gb"
  default     = 15
}

variable "disk_type" {
  type        = string
  description = "Disk type for the google compute instance"
  default     = "pd-standard"
}

variable "network_tier" {
  type        = string
  description = "Network tier for the google compute instance"
  default     = "STANDARD"
}
