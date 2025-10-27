variable "function_name" {}
variable "source_file" {}
variable "handler" {}
variable "runtime" {
  default = "python3.12"
}
variable "role_arn" {}
variable "environment_variables" {
  type    = map(string)
  default = {}
}
variable "tags" {
  type    = map(string)
  default = {}
}