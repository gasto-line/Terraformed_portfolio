locals {
  counter_template = file("${path.module}/resume_files/counter_template.js")
  counter_js       = replace(local.counter_template, "__API_GATEWAY_URL__", "${aws_apigatewayv2_api.resume_api.api_endpoint}/increment")
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}
