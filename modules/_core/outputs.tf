output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "cf_distro_id" {
  value = module.cloudfront_s3.cf_distro_id
}

output "cf_domain_name" {
  value = module.cloudfront_s3.cf_domain_name
}

output "migrate_task_subnets" {
  value = module.vpc.private_subnet_ids
}

output "migrate_task_security_group" {
  value = module.security_groups.api_sg.id
}
