resource "aws_cloudfront_origin_access_control" "PF_oac" {
  name                              = "terraformed-PF-cloudfront-oac"
  description                       = "OAC for CloudFront to access S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "PF_cloudfront" {
  origin {
    domain_name              = aws_s3_bucket.PF_bucket.bucket_regional_domain_name
    origin_id                = "PF-s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.PF_oac.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "PF-s3-origin"

    viewer_protocol_policy = "redirect-to-https"
    compress              = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true  # Use default CloudFront SSL
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "PF CloudFront"
  }
}
