resource "aws_s3_bucket" "resume_bucket" {
  bucket = "terraformed-resume-bucket"  # Change to a unique name

  tags = {
    Name        = "Resume Bucket"
    Environment = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "resume_bucket_block" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "resume_website" {
  bucket = aws_s3_bucket.resume_bucket.id

  index_document {
    suffix = "index.html"
  }

}


resource "aws_s3_bucket_policy" "resume_bucket_policy" {
  bucket = aws_s3_bucket.resume_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.resume_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.resume_cloudfront.arn
          }
        }
      }
    ]
  })
}



# Here we define and upload all the files that we want in our s3 bucket
resource "aws_s3_object" "resume_index" {
  bucket = aws_s3_bucket.resume_bucket.id
  key    = "index.html"
  source = "./resume_files/CV_2025.html"
  content_type = "text/html"
  etag = filemd5("./resume_files/CV_2025.html")
}

resource "aws_s3_object" "resume_js_script" {
  bucket = aws_s3_bucket.resume_bucket.id
  key    = "script.js"
  source = "./resume_files/script.js"
  content_type = "application/javascript"
  etag = filemd5("./resume_files/script.js")
}

resource "aws_s3_object" "resume_css_script" {
  bucket = aws_s3_bucket.resume_bucket.id
  key    = "booster.css"
  source = "./resume_files/booster.css"
  content_type = "text/css"
  etag = filemd5("./resume_files/booster.css")
}

resource "aws_s3_object" "counter_js" {
  bucket        = aws_s3_bucket.resume_bucket.id
  key           = "counter.js"
  content       = local.counter_js
  content_type  = "application/javascript"
}