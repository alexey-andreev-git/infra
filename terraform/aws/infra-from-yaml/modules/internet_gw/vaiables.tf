variable "vpc" {
  description = "Virtual private networks for the distribution."
  type        = any
}

variable "igws" {
  description = "Internet gateways for the distribution."
  type        = any
}

# variable "tags_name" {
#   description = "Name for the gateway."
#   type        = string
# }