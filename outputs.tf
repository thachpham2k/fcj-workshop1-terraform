output "bucket-name" {
  value = module.s3.s3-bucket.bucket
}

output "s3-website-url" {
  value = module.s3.webdomain
}

output "codecommit-url-ssh" {
  value = module.codepipeline.codecommit.clone_url_ssh
}

output "codecommit-url-http" {
  value = module.codepipeline.codecommit.clone_url_http
}

output "s3-artifact" {
  value = module.codepipeline.s3.bucket
}