variable "deployment_id" {
  description = "ID for vpc."
  type        = string
}

variable "id" {
  description = "VPC ID for existing VPC."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for VPC."
  type        = string
}

variable "tags_name" {
  description = "Tags name for VPC."
  type        = string
}
