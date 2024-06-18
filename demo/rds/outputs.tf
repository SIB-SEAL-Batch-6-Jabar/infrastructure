output "rds_endpoint" {
  value = aws_db_instance.simanis-db.endpoint
}

output "rds_instance_identifier" {
  value = aws_db_instance.simanis-db.id
}