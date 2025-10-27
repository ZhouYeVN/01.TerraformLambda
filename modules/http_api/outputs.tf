# Url of the HTTP API Gateway
output "api_url" {
  value = aws_apigatewayv2_api.this.api_endpoint
}