module "sqs" {
  for_each = var.sqs_parameters
  source   = "terraform-aws-modules/sqs/aws"
  version  = "5.1.0"

  name                        = "${local.common_name}-${each.key}"
  region                      = try(each.value.region, var.sqs_defaults.region, null)
  content_based_deduplication = try(each.value.content_based_deduplication, var.sqs_defaults.content_based_deduplication, false)
  deduplication_scope         = try(each.value.deduplication_scope, var.sqs_defaults.deduplication_scope, null)
  delay_seconds               = try(each.value.delay_seconds, var.sqs_defaults.delay_seconds, "0")
  fifo_queue                  = try(each.value.fifo_queue, var.sqs_defaults.fifo_queue, false)
  fifo_throughput_limit       = try(each.value.fifo_throughput_limit, var.sqs_defaults.fifo_throughput_limit, null)
  max_message_size            = try(each.value.max_message_size, var.sqs_defaults.max_message_size, "262144")
  message_retention_seconds   = try(each.value.message_retention_seconds, var.sqs_defaults.message_retention_seconds, "345600")
  visibility_timeout_seconds  = try(each.value.visibility_timeout_seconds, var.sqs_defaults.visibility_timeout_seconds, "30")

  kms_data_key_reuse_period_seconds = try(each.value.kms_data_key_reuse_period_seconds, var.sqs_defaults.kms_data_key_reuse_period_seconds, null)
  kms_master_key_id                 = try(each.value.kms_master_key_id, var.sqs_defaults.kms_master_key_id, null)
  use_name_prefix                   = try(each.value.use_name_prefix, var.sqs_defaults.use_name_prefix, false)
  receive_wait_time_seconds         = try(each.value.receive_wait_time_seconds, var.sqs_defaults.receive_wait_time_seconds, null)
  redrive_allow_policy              = try(each.value.redrive_allow_policy, var.sqs_defaults.redrive_allow_policy, {})
  redrive_policy                    = try(each.value.redrive_policy, var.sqs_defaults.redrive_policy, {})
  sqs_managed_sse_enabled           = try(each.value.sqs_managed_sse_enabled, var.sqs_defaults.sqs_managed_sse_enabled, true)

  # Queue policy
  create_queue_policy             = try(each.value.create_queue_policy, var.sqs_defaults.create_queue_policy, false)
  source_queue_policy_documents   = try(each.value.source_queue_policy_documents, var.sqs_defaults.source_queue_policy_documents, [])
  override_queue_policy_documents = try(each.value.override_queue_policy_documents, var.sqs_defaults.override_queue_policy_documents, [])
  queue_policy_statements         = try(each.value.queue_policy_statements, var.sqs_defaults.queue_policy_statements, {})

  # DLQ
  create_dlq                            = try(each.value.create_dlq, var.sqs_defaults.create_dlq, false)
  dlq_content_based_deduplication       = try(each.value.dlq_content_based_deduplication, var.sqs_defaults.dlq_content_based_deduplication, null)
  dlq_deduplication_scope               = try(each.value.dlq_deduplication_scope, var.sqs_defaults.dlq_deduplication_scope, null)
  dlq_delay_seconds                     = try(each.value.dlq_delay_seconds, var.sqs_defaults.dlq_delay_seconds, null)
  dlq_kms_data_key_reuse_period_seconds = try(each.value.dlq_kms_data_key_reuse_period_seconds, var.sqs_defaults.dlq_kms_data_key_reuse_period_seconds, null)
  dlq_kms_master_key_id                 = try(each.value.dlq_kms_master_key_id, var.sqs_defaults.dlq_kms_master_key_id, null)
  dlq_message_retention_seconds         = try(each.value.dlq_message_retention_seconds, var.sqs_defaults.dlq_message_retention_seconds, null)
  dlq_name                              = try(each.value.dlq_name, var.sqs_defaults.dlq_name, null)
  dlq_receive_wait_time_seconds         = try(each.value.dlq_receive_wait_time_seconds, var.sqs_defaults.dlq_receive_wait_time_seconds, null)
  create_dlq_redrive_allow_policy       = try(each.value.create_dlq_redrive_allow_policy, var.sqs_defaults.create_dlq_redrive_allow_policy, true)
  dlq_redrive_allow_policy              = try(each.value.dlq_redrive_allow_policy, var.sqs_defaults.dlq_redrive_allow_policy, {})
  dlq_sqs_managed_sse_enabled           = try(each.value.dlq_sqs_managed_sse_enabled, var.sqs_defaults.dlq_sqs_managed_sse_enabled, true)
  dlq_fifo_throughput_limit             = try(each.value.dlq_fifo_throughput_limit, var.sqs_defaults.dlq_fifo_throughput_limit, null)
  dlq_visibility_timeout_seconds        = try(each.value.dlq_visibility_timeout_seconds, var.sqs_defaults.dlq_visibility_timeout_seconds, null)
  dlq_tags                              = try(each.value.dlq_tags, var.sqs_defaults.dlq_tags, {})

  # DLQ policy
  create_dlq_queue_policy             = try(each.value.create_dlq_queue_policy, var.sqs_defaults.create_dlq_queue_policy, false)
  source_dlq_queue_policy_documents   = try(each.value.source_dlq_queue_policy_documents, var.sqs_defaults.source_dlq_queue_policy_documents, [])
  override_dlq_queue_policy_documents = try(each.value.override_dlq_queue_policy_documents, var.sqs_defaults.override_dlq_queue_policy_documents, [])
  dlq_queue_policy_statements         = try(each.value.dlq_queue_policy_statements, var.sqs_defaults.dlq_queue_policy_statements, {})

  tags = merge(local.common_tags, try(each.value.tags, var.sqs_defaults.tags, null))
}