resource "aws_apigatewayv2_api" "resume_api" {
  name          = "terraformed-resume-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  name        = "$default"
  api_id      = aws_apigatewayv2_api.resume_api.id
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.resume_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.resume_counter_incrementer.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "get_increment" {
  api_id    = aws_apigatewayv2_api.resume_api.id
  route_key = "GET /increment"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.resume_counter_incrementer.function_name
  principal     = "apigateway.amazonaws.com"
  # source_arn format: arn:aws:execute-api:<region>:<account_id>:<api_id>/<stage>/<method>/<path>
  source_arn    = "${aws_apigatewayv2_api.resume_api.execution_arn}/*/*"
}

locals {
  counter_template = file("${path.module}/resume_files/counter_template.js")
  counter_js       = replace(local.counter_template, "__API_GATEWAY_URL__", "${aws_apigatewayv2_api.resume_api.api_endpoint}/increment")
}