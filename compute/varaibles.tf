variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}

variable "asg_security_group_id" {} 