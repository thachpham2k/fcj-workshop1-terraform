output "webdomain" {
  value = aws_s3_bucket_website_configuration.bucket_static_web_host.website_endpoint
}

output "s3-bucket" {
  value = aws_s3_bucket.s3_bucket
}