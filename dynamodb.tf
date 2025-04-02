resource "aws_dynamodb_table" "resume_counter" {
  name           = "terraformed-resume-visitor-counter"
  billing_mode   = "PAY_PER_REQUEST"  # No need to specify read/write capacity
  hash_key       = "id"               # Primary key

  attribute {
    name = "id"
    type = "S"  # "S" stands for String
  }

  tags = {
    Name        = "Resume Visitor Counter"
    Environment = "Terraform"
  }
}
