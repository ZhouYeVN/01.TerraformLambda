variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Default tags for resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "learning"
  }
}