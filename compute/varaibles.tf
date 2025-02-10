variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "alb_target_group_arn" {}
variable "asg_security_group_id" {} 