resource "aws_s3_bucket" "cv-content" {
  bucket = "cv-content"

  tags = {
    environment  = "production"
    project      = "cloud-challenge"
    generated_by = "terraform-cloud"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.cv-content.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.cv-content.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.cv-content.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
resource "aws_s3_bucket_public_access_block" "access_good_1" {
  bucket = aws_s3_bucket.cv-content.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.cv-content.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}
