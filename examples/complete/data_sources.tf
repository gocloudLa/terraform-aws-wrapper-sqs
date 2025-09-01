data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# data "aws_sns_topic" "base-alerts" {
#   name = "${local.common_name_prefix}-alerts"
# }

# data "aws_sns_topic" "project-alerts" {
#   name = "${local.common_name}-alerts"
# }
