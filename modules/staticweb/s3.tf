resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project-name}-${random_integer.s3-suffix.result}"
  force_destroy = true
  tags   = var.project-tags
}

resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id

  policy = templatefile("${path.root}/${path.module}/s3_policy.json.tpl", {
    bucket_name = "${aws_s3_bucket.s3_bucket.bucket}"
  })
  depends_on = [ aws_s3_bucket.s3_bucket, aws_s3_bucket_ownership_controls.bucket_owner, aws_s3_bucket_public_access_block.bucket_public_access_block]
}

resource "aws_s3_bucket_website_configuration" "bucket_static_web_host" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }
}