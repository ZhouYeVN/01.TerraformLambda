# Shared IAM role
module "iam" {
  source = "./iam"
  tags   = var.tags
}

# Number processor service
module "number_processor" {
  source          = "./services/number_processor"
  lambda_role_arn = module.iam.lambda_exec_role_arn
}