data "archive_file" "zip" {
  type        = "zip"
  source_file = var.source_file
  output_path = "generated/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  filename         = data.archive_file.zip.output_path
  handler          = var.handler
  runtime          = var.runtime
  role             = var.role_arn
  source_code_hash = data.archive_file.zip.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  tags = var.tags

  depends_on = [data.archive_file.zip]
}