resource "aws_lambda_function" "PF_counter_incrementer" {
  function_name = "terraformed-PF-counter-incrementer"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_dynamodb.lambda_handler"
  runtime       = "python3.11"
  filename      = "build/lambda_dynamodb.zip"

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.PF_counter.name
    }
  }
}

