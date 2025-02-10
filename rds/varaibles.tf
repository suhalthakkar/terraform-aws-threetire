variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to deploy RDS instance."
  type        = list(string)
}