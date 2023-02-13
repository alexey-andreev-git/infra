variable "projects" {}
variable "vpc_networks" {}
variable "vpc_subnets" {}

variable "oauth_scopes" {
  type        = list
  description = "The set of Google API scopes to be made available on all of the node VMs under the service account. These can be either FQDNs, or scope aliases."
  default     = ["https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
}

variable "service_account" {
  description = "The service account to be used by the node pool VMs."
  default     = ""
}

variable "username" {
    type = string
    default = ""
}

variable "password" {
    type = string
    default = ""
}

