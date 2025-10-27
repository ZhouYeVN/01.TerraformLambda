variable "api_name" {}
variable "lambda_invoke_arn" {}
variable "lambda_function_name" {}
variable "tags" {
  type    = map(string)
  default = {}
}