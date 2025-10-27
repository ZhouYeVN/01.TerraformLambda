variable "queue_name" {}
variable "retention_period" {
  type    = number
  default = 1209600  # 14 days
}
variable "tags" {
  type    = map(string)
  default = {}
}