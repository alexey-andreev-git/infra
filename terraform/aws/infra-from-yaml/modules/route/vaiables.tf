variable "vpc" {
  description = "The VPC."
  type        = any
}

variable "subnets" {
  description = "Define for the networks."
  type        = any
}

variable "gateways" {
  description = "Define for the gateway."
  type        = any
}

variable "routes" {
  description = "Define for the routes."
  type        = any
}

# variable "tags_name" {
#   description = "Name for the distribution."
#   type        = string
# }

