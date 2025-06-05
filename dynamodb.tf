resource "aws_dynamodb_table" "PF_counter" {
  name           = "terraformed-PF-visitor-counter"
  billing_mode   = "PAY_PER_REQUEST"  # No need to specify read/write capacity
  hash_key       = "id"               # Primary key

  attribute {
    name = "id"
    type = "S"  # "S" stands for String
  }

  tags = {
    Name        = "PF Visitor Counter"
    Environment = "Terraform"
  }
}
