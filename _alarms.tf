# //alerta si se estan encolando peticiones y se esta llegando al limite
# module "sqs_inflight_limit_alarm" {
#   for_each = var.sqs_parameters
#   source   = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
#   version  = "4.2.1"

#   create_metric_alarm = try(each.value.alarms_parameters["inflight-message-limit"].create, false)
#   alarm_name          = "${local.common_name}-${each.key}-inflight-message-limit"
#   alarm_description   = "Pending message is to high"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = try(each.value.alarms_parameters["inflight-message-limit"].evaluation_periods, 1)
#   threshold           = try(each.value.alarms_parameters["inflight-message-limit"].threshold, 100000)
#   unit                = "Count"
#   metric_name         = "ApproximateNumberOfMessagesNotVisible"
#   namespace           = "AWS/SQS"
#   period              = try(each.value.alarms_parameters["inflight-message-limit"].period, 300) //5minutos
#   statistic           = "Maximum"
#   actions_enabled     = true
#   datapoints_to_alarm = null
#   dimensions = {
#     QueueName = "${local.common_name}-${each.key}"
#   }

#   alarm_actions                         = [var.aws_sns_topic_alerts, try(data.aws_sns_topic.base-alerts[each.key].arn, "")]
#   insufficient_data_actions             = null
#   ok_actions                            = null
#   extended_statistic                    = null
#   treat_missing_data                    = "missing"
#   evaluate_low_sample_count_percentiles = null
#   metric_query                          = []
#   tags                                  = local.common_tags

# }

# #si cantidad de mensajes enviados esta abajo de valores habituales
# module "sqs_alarm_number_messages_sent" {
#   for_each = var.sqs_parameters
#   source   = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
#   version  = "4.2.1"

#   create_metric_alarm = try(each.value.alarms_parameters["number-of-messages-sent"].create, false)
#   alarm_name          = "${local.common_name}-${each.key}-number-of-messages-sent"
#   alarm_description   = "Messages sending is to low"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = try(each.value.alarms_parameters["number-of-messages-sent"].evaluation_periods, 1)
#   threshold           = try(each.value.alarms_parameters["number-of-messages-sent"].threshold, 100)
#   threshold_metric_id = null
#   unit                = "Count"
#   metric_name         = "NumberOfMessagesSent"
#   namespace           = "AWS/SQS"
#   period              = try(each.value.alarms_parameters["number-of-messages-sent"].period, 300)
#   statistic           = "Sum"
#   actions_enabled     = true
#   datapoints_to_alarm = null
#   dimensions = {
#     QueueName = "${local.common_name}-${each.key}"
#   }
#   alarm_actions                         = [var.aws_sns_topic_alerts, try(data.aws_sns_topic.base-alerts[each.key].arn, "")]
#   insufficient_data_actions             = null
#   ok_actions                            = null
#   extended_statistic                    = null
#   treat_missing_data                    = "missing"
#   evaluate_low_sample_count_percentiles = null
#   metric_query                          = []
#   tags                                  = local.common_tags
# }

# #indica si hay mensajes que estan tardando mas tiempo de lo normal en ser procesados
# module "sqs_alarm_age_oldest_message" {
#   for_each = var.sqs_parameters
#   source   = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
#   version  = "4.2.1"

#   create_metric_alarm = try(each.value.alarms_parameters["age-of-oldest-message"].create, false)
#   alarm_name          = "${local.common_name}-${each.key}-age-of-oldest-message"
#   alarm_description   = "Age message is to high"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = try(each.value.alarms_parameters["age-of-oldest-message"].evaluation_periods, 1)
#   threshold           = try(each.value.alarms_parameters["age-of-oldest-message"].threshold, 5)
#   threshold_metric_id = null
#   unit                = "Seconds"
#   metric_name         = "ApproximateAgeOfOldestMessage"
#   namespace           = "AWS/SQS"
#   period              = try(each.value.alarms_parameters["age-of-oldest-message"].period, 300)
#   statistic           = "Maximum"
#   actions_enabled     = true
#   datapoints_to_alarm = null
#   dimensions = {
#     QueueName = "${local.common_name}-${each.key}"
#   }
#   alarm_actions                         = [var.aws_sns_topic_alerts, try(data.aws_sns_topic.base-alerts[each.key].arn, "")]
#   insufficient_data_actions             = null
#   ok_actions                            = null
#   extended_statistic                    = null
#   treat_missing_data                    = "missing"
#   evaluate_low_sample_count_percentiles = null
#   metric_query                          = []
#   tags                                  = local.common_tags

#   depends_on = [
#     module.sqs
#   ]
# }