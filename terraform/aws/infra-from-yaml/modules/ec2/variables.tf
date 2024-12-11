variable "subnet" {
  description = "EC2 networks for the distribution."
  type        = any
}

variable "sgs" {
  description = "Security group ID for the distribution."
  type        = any
}

variable "ec2" {
  description = "EC2 values for the distribution."
  type        = any
}
