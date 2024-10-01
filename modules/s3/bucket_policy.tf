resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Statement = [
      merge({
        Actions   = "*"
        Effect    = "Allow"
        Principal = "*"
        Resource  = "*"
      })
    ]
    Version = "2012-10-17"
  })
}
