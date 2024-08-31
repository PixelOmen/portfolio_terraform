output "env_bucket_arn" {
  value = aws_s3_bucket.env_bucket.arn
}

output "media_bucket_arn" {
  value = aws_s3_bucket.media_bucket.arn
}

output "cf_distro_id" {
  value = aws_cloudfront_distribution.cf_distro.id
}
