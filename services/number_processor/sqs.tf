module "main_queue" {
  source          = "../../modules/sqs"
  queue_name      = "number-processor-main"
  tags            = var.tags
}

module "dlq_queue" {
  source          = "../../modules/sqs"
  queue_name      = "number-processor-dlq"
  retention_period = 999999
  tags            = var.tags
}