variable "deployment_id" {
  description = "Deployment ID for security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security group."
  type        = string
}

variable "security_groups" {
  description = "Security groups for security group."
  type        = any
}