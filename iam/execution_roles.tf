variable "tags" {
  type = map(string)
  default = {} # default if none provided
}

resource "aws_iam_role" "lambda_exec" { # IAM role for Lambda execution
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# AWS managed: Lambda -> CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Custom policy: Lambda -> SQS to allow sending messages to the SQS FIFO queue
resource "aws_iam_role_policy" "lambda_sqs_send" {
  role = aws_iam_role.lambda_exec.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
        ]
      Resource = "*"
    }]
  })
}

# Output the ARN
output "lambda_exec_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}