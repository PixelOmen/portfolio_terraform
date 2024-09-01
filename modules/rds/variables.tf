variable "prefix" {
  type        = string
  description = "The prefix for the resources"
}

variable "environment" {
  type        = string
  description = "The target environment"
}

variable "region" {
  type        = string
  description = "The target region"
}

variable "rds_sg_id" {
  type        = string
  description = "The ID of the RDS security group"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The IDs of the private subnets"
}

variable "rds_username" {
  type        = string
  description = "The username for the RDS instance"
}

variable "rds_password" {
  type        = string
  description = "The password for the RDS instance"
}

variable "rds_db_name" {
  type        = string
  description = "The name of the RDS database"
}
