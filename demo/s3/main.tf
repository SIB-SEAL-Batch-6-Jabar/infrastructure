resource "aws_s3_bucket" "simanis_bucket" {
  bucket = var.bucket
    tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_s3_bucket_public_access_block" "simanis_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.simanis_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}