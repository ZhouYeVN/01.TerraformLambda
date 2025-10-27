# Declare variables passed from root
variable "lambda_role_arn" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}

# API Gateway
module "api" {
  source                = "../../modules/http_api"
  api_name              = "number-processor-api"
  lambda_invoke_arn     = module.lambda.invoke_arn
  lambda_function_name  = module.lambda.function_name
  tags                  = var.tags
}