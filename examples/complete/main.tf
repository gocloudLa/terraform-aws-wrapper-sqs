module "sqs" {
  source = "../../"

  metadata = local.metadata
  project  = local.project

  sqs_parameters = {
    "example" = {
      #content_based_deduplication = false
      #deduplication_scope         = null
      #delay_seconds               = "0"
      #fifo_queue                  = false
      #fifo_throughput_limit       = null
      #max_message_size            = "262144"
      #message_retention_seconds   = "345600"
      #visibility_timeout_seconds  = "30"
      #tags                        = local.common_tags
    }
    "examplepolicy" = {
      create_queue_policy = true
      queue_policy_statements = {
        sns = {
          sid     = "SNSPublish"
          actions = ["sqs:SendMessage"]

          principals = [
            {
              type        = "Service"
              identifiers = ["sns.amazonaws.com"]
            }
          ]
        }
      }
      #create_dlq                   = true
      #content_based_deduplication = false
      #deduplication_scope         = null
      #delay_seconds               = "0"
      #fifo_queue                  = false
      #fifo_throughput_limit       = null
      #max_message_size            = "262144"
      #message_retention_seconds   = "345600"
      #visibility_timeout_seconds  = "30"
      #tags                        = local.common_tags
    }
    "example.fifo" = {
      #content_based_deduplication = false
      #deduplication_scope         = null
      #delay_seconds               = "0"
      fifo_queue = true
      #fifo_throughput_limit       = null
      #max_message_size            = "262144"
      #message_retention_seconds   = "345600"
      #visibility_timeout_seconds  = "30"
      #tags                        = local.common_tags
    }
    # "example-alarms" = {
    #   # Si no se quiere autodescubrir el Alerts Base Dafault
    #   # alarms_sns_topic_name = "" # Default: {local.common_name_prefix}-{each.key}
    #   alarms_parameters = {
    #     "inflight-message-limit" = {
    #       create = true # Default: false
    #       # evaluation_periods = 1
    #       # threshold = 100000
    #       # period = 300
    #     }
    #     "number-of-messages-sent" = {
    #       create = true # Default: false
    #       # evaluation_periods = 1
    #       # threshold = 100
    #       # period = 300
    #     }
    #     "age-of-oldest-message" = {
    #       create = true # Default: false
    #       # evaluation_periods = 1
    #       # threshold = 5
    #       # period = 300
    #     }
    #   }
    # }

  }
  sqs_defaults = var.sqs_defaults
}