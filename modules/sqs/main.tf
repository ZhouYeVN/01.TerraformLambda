locals {
  # FIFO queue names must end with the .fifo suffix
  fifo_name = endswith(var.queue_name, ".fifo") ? var.queue_name : "${var.queue_name}.fifo"
}

resource "aws_sqs_queue" "this" {
  name                      = local.fifo_name
  fifo_queue                = true
  # don’t need to provide a MessageDeduplicationId when sending messages—SQS computes a hash of the message body instead
  content_based_deduplication = true
  message_retention_seconds = var.retention_period

  tags = var.tags
}