resource "aws_iam_role" "lambda_exec" {
  name = "terraformed_lambda_dynamodb_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}


resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_kms" {
  role       = aws_iam_role.lambda_exec.name
  #We assign a policy that was created manually via the aws console to authorize encryption and decryption of kms keys
  policy_arn = "arn:aws:iam::${var.account_id}:policy/kms-encryptionANDdecryption-lambda"
}
