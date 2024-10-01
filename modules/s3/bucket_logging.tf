resource "aws_s3_bucket_logging" "example" {
  count  = var.access_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id

  # If bucket specified, otherwise use created
  target_bucket = var.access_logging_bucket == null ? aws_s3_bucket.access_logs[0].id : var.access_logging_bucket
  target_prefix = "log/${var.bucket_name}"
}

resource "aws_s3_bucket" "access_logs" {
  #checkov:skip=CKV2_AWS_61: "This is a demo bucket"
  #checkov:skip=CKV2_AWS_62: "This is a demo bucket"
  #checkov:skip=CKV_AWS_144: "This is a demo bucket"
  #checkov:skip=CKV_AWS_145: "This is a demo bucket"
  #checkov:skip=CKV_AWS_21: "This is a demo bucket"
  #checkov:skip=CKV2_AWS_6: "This is a demo bucket"
  count  = var.access_logging ? var.access_logging_bucket == null ? 1 : 0 : 0
  bucket = var.access_logging_bucket
}
