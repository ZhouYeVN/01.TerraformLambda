module "lambda" {
  source                = "../../modules/lambda"
  function_name         = "number-processor"
  source_file           = "${path.module}/number_processor.py"
  handler               = "number_processor.lambda_handler" # entry point function name
  role_arn              = var.lambda_role_arn
  environment_variables = {
    MAIN_QUEUE_URL = module.main_queue.url
    DLQ_QUEUE_URL  = module.dlq_queue.url
  }
  tags = var.tags
}