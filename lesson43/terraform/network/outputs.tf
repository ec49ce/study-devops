output "subnets_cidr_blocks" {
  value = local.subnets_cidr_blocks
}

output "database_route_table_ids" {
  value = module.vpc.database_route_table_ids
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}