output "rds_endpoint" {
  value = module.core_infra.rds_endpoint
}

output "cf_distro_id" {
  value = module.core_infra.cf_distro_id
}

output "migrate_task_subnets" {
  value = module.core_infra.migrate_task_subnets
}

output "migrate_task_security_group" {
  value = module.core_infra.migrate_task_security_group
}
