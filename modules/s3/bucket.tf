resource "aws_s3_bucket" "this" {
  #checkov:skip=CKV2_AWS_61: "This is a demo bucket"
  #checkov:skip=CKV2_AWS_62: "This is a demo bucket"
  #checkov:skip=CKV_AWS_144: "This is a demo bucket"
  #checkov:skip=CKV_AWS_145: "This is a demo bucket"
  #checkov:skip=CKV_AWS_21: "This is a demo bucket"
  #checkov:skip=CKV2_AWS_6: "This is a demo bucket"
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}
