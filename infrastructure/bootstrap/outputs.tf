output "s3_bucket_name" {
  value       = aws_s3_bucket.state_bucket.id
  description = "Name of the S3 state storage bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.lock_table.name
  description = "Name of the DynamoDB locking matrix table"
}
