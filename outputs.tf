output "number_processor_api_url" {
  value = module.number_processor.api_url
}

output "number_processor_main_queue_url" {
  value = module.number_processor.main_queue_url
}

output "number_processor_dlq_queue_url" {
  value = module.number_processor.dlq_queue_url
}

output "number_processor_invoke_arn" {
  value = module.number_processor.invoke_arn
}

output "number_processor_function_name" {
  value = module.number_processor.function_name
}