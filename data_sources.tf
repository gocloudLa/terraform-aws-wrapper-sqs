data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# locals {
#   sns_topic_calculated = {
#     for sqs_key, sqs_config in var.sqs_parameters :
#     sqs_key => {
#       "sns_topic_name" = try(sqs_config.alarms_sns_topic_name, local.sns_topic_name_default)
#       } if(
#       try(sqs_config.alarms_parameters["inflight-message-limit"].create, false) != false ||
#       try(sqs_config.alarms_parameters["number-of-messages-sent"].create, false) != false ||
#       try(sqs_config.alarms_parameters["age-of-oldest-message"].create, false) != false
#     )
#   }

#   sns_topic_name_default = "${local.common_name_prefix}-alerts"
# }

# data "aws_sns_topic" "base-alerts" {
#   for_each = local.sns_topic_calculated

#   name = each.value.sns_topic_name
# }