output "env_bucket_arn" {
  value = aws_s3_bucket.env_bucket.arn
}

output "media_bucket_arn" {
  value = aws_s3_bucket.media_bucket.arn
}
