output "api_url" {
  value = module.api.api_url
}

output "main_queue_url" {
  value = module.main_queue.url
}

output "dlq_queue_url" {
  value = module.dlq_queue.url
}

output "invoke_arn" {
  value = module.lambda.invoke_arn
}

output "function_name" {
  value = module.lambda.function_name
}