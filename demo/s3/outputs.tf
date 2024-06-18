output "s3_bucket_name" {
  value = aws_s3_bucket.simanis_bucket.bucket
}

output "s3_endpoint" {
  value = "https://${aws_s3_bucket.simanis_bucket.bucket}.s3.${var.aws_region}.amazonaws.com"
}

output "s3_hostname" {
  value = "https://${aws_s3_bucket.simanis_bucket.bucket}.s3.amazonaws.com"
}
