resource "aws_s3_bucket" "PF_bucket" {
  bucket = "terraformed-portfolio-bucket"  # Change to a unique name

  tags = {
    Name        = "PF Bucket"
    Environment = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "PF_bucket_block" {
  bucket = aws_s3_bucket.PF_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "PF_website" {
  bucket = aws_s3_bucket.PF_bucket.id

  index_document {
    suffix = "index.html"
  }

}


resource "aws_s3_bucket_policy" "PF_bucket_policy" {
  bucket = aws_s3_bucket.PF_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.PF_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.PF_cloudfront.arn
          }
        }
      }
    ]
  })
}


resource "aws_s3_object" "cloud_PF_index" {
  bucket = aws_s3_bucket.PF_bucket.id
  key    = "index.html"
  source = var.cloud_PF_path
  content_type = "text/html"
  etag = filemd5("./PF_files/index.html")
}


resource "aws_s3_object" "cv_en" {
  bucket        = aws_s3_bucket.PF_bucket.id
  key           = "cv_en.pdf"
  source       = var.cv_en_path
  content_type  = "application/pdf"
}

resource "aws_s3_object" "cv_fr" {
  bucket        = aws_s3_bucket.PF_bucket.id
  key           = "cv_fr.pdf"
  source       = var.cv_fr_path
  content_type  = "application/pdf"
}

resource "aws_s3_object" "counter_js" {
  bucket        = aws_s3_bucket.PF_bucket.id
  key           = "counter.js"
  content       = local.counter_js
  content_type  = "application/javascript"
}

