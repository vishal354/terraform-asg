variable "region" {
  type        = string
  description = "Name of the region where resources will be created"
}

variable "vpc_id" {
  type        = string
  description = "VPC in which target group will be created"
}

variable "key_name" {
  type        = string
  description = "Name of the key used to SSH in the instance"
}

variable "instance_type" {
  type        = string
  description = "Type of instance that will be provisioned"
}

variable "image_id" {
  type        = string
  description = "AMI ID of the ami that will be used in launch template"
}

variable "instance_security_group_ids" {
  type        = list(string)
  description = "List of ids of all the security groups that will be attached in the launch template"
}

variable "load_balancer_security_group_ids" {
  type        = list(string)
  description = "List of ids of all the security groups that will be attached in the launch template"
}

variable "root_block_size" {
  type        = number
  description = "The size of the volume attached to the instance in GBs"
}

variable "service_name" {
  type        = string
  description = "Name of the service whose autoscaling group is created"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones where the infra will be provisioned"
}

variable "elb_subnets" {
  type        = list(string)
  description = "List of subnets where ELB will be provisioned"
}

variable "env_name" {
  type = string
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired capacity for the autoscaling group"
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size for autoscaling group"
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size for autoscaling group"
}