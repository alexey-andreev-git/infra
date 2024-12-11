variable "vpc_id" {
  description = "VPC ID for sub-network."
  type        = string
}

variable "subnets" {
  description = "Subnets for sub-network."
  type        = any
}