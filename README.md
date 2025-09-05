# Standard Platform - Terraform Module 🚀🚀
<p align="right"><a href="https://partners.amazonaws.com/partners/0018a00001hHve4AAC/GoCloud"><img src="https://img.shields.io/badge/AWS%20Partner-Advanced-orange?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Partner"/></a><a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=for-the-badge&logo=apache&logoColor=white" alt="LICENSE"/></a></p>

Welcome to the Standard Platform — a suite of reusable and production-ready Terraform modules purpose-built for AWS environments.
Each module encapsulates best practices, security configurations, and sensible defaults to simplify and standardize infrastructure provisioning across projects.

## 📦 Module: Terraform SQS Module
<p align="right"><a href="https://github.com/gocloudLa/terraform-aws-wrapper-sqs/releases/latest"><img src="https://img.shields.io/github/v/release/gocloudLa/terraform-aws-wrapper-sqs.svg?style=for-the-badge" alt="Latest Release"/></a><a href=""><img src="https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-wrapper-sqs.svg?style=for-the-badge" alt="Last Commit"/></a><a href="https://registry.terraform.io/modules/gocloudLa/wrapper-sqs/aws"><img src="https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Registry"/></a></p>
The Terraform wrapper for SQS simplifies the configuration of the Queue Service in the AWS cloud. This wrapper functions as a predefined template, facilitating the creation and management of SQS queues by handling all the technical details.

### ✨ Features

- 🔔 [Message limit alarm](#message-limit-alarm) - Generate an alert when requests are being queued and therefore the limit is being reached.

- 📜 [Add policy to the queue](#add-policy-to-the-queue) - Generate an SQS queue policy to allow actions on the queue created with the module.

- 🔔 [Alarm for number of messages sent](#alarm-for-number-of-messages-sent) - Generate an alert when the number of messages sent is below usual values.

- 🔔 [Old messages alarm](#old-messages-alarm) - Generate an alert when there are messages that are taking longer than usual to be processed.



### 🔗 External Modules
| Name | Version |
|------|------:|
| <a href="https://github.com/terraform-aws-modules/terraform-aws-sqs" target="_blank">terraform-aws-modules/sqs/aws</a> | 5.0.0 |



## 🚀 Quick Start
```hcl
sqs_parameters = {
    "example" = {
    },
    "example.fifo" = {
      fifo_queue  = false
    }
  }
```


## 🔧 Additional Features Usage

### Message limit alarm
Generate an alert when requests are being queued and therefore the limit is being reached.


<details><summary>Configuration Code</summary>

```hcl
sqs_parameters = {
    "example" = {
      ...
      alarms_parameters = {
        inflight-message-limit = {
          create = true
          evaluation_periods = 1
          threshold = 100000
          period = 300
        }
      }
      ...
    }
  }
  ...
```


</details>


### Add policy to the queue
Generate an SQS queue policy to allow actions on the queue created with the module.


<details><summary>Configuration Code</summary>

```hcl
sqs_parameters = {
    "example" = {
      ...
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
      ...
    }
  }
  ...
```


</details>


### Alarm for number of messages sent
Generate an alert when the number of messages sent is below usual values.


<details><summary>Configuration Code</summary>

```hcl
sqs_parameters = {
    "sqs-01" = {
      ...
      alarms_parameters = {
        number-of-messages-sent = {
          create = true
          evaluation_periods = 1
          threshold = 100
          period = 300
        }
      }
      ...
    }
  }
  ...
```


</details>


### Old messages alarm
Generate an alert when there are messages that are taking longer than usual to be processed.


<details><summary>Configuration Code</summary>

```hcl
sqs_parameters = {
    "sqs-01" = {
      ...
      alarms_parameters = {
        age-of-oldest-message = {
          create = true
          evaluation_periods = 1
          threshold = 5
          period = 300

        }
      }
      ...
    }
  }
  ...
```


</details>




## 📑 Inputs
| Name                                  | Description                                                                                                                                                                                                                         | Type     | Default                                   | Required |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ----------------------------------------- | -------- |
| content_based_deduplication           | Enables content-based deduplication for FIFO queues                                                                                                                                                                                 | `bool`   | `false`                                   | no       |
| deduplication_scope                   | Specifies whether message deduplication occurs at the message group or queue level.                                                                                                                                                 | `string` | `null`                                    | no       |
| delay_seconds                         | The time in seconds for which the delivery of all messages in the queue will be delayed                                                                                                                                             | `string` | `"0"`                                     | no       |
| fifo_queue                            | Boolean that designates a FIFO queue                                                                                                                                                                                                | `bool`   | `false`                                   | no       |
| fifo_throughput_limit                 | Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group.                                                                                                                                 | `string` | `null`                                    | no       |
| max_message_size                      | The limit of how many bytes a message can contain before Amazon SQS rejects it.                                                                                                                                                     | `string` | `"262144"`                                | no       |
| message_retention_seconds             | The amount of seconds Amazon SQS retains a message                                                                                                                                                                                  | `string` | `"345600"`                                | no       |
| visibility_timeout_seconds            | The queue visibility timeout                                                                                                                                                                                                        | `string` | `"30"`                                    | no       |
| alarms_sns_topic_name                 | Allow to define custom SNS Topic Name for Alarms                                                                                                                                                                                    | `string` | `"{local.common_name_prefix}-{each.key}"` | no       |
| kms_data_key_reuse_period_seconds     | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours) | `number` | `null`                                    | no       |
| kms_master_key_id                     | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK                                                                                                                                                   | `string` | `null`                                    | no       |
| use_name_prefix                       | Determines whether `name` is used as a prefix                                                                                                                                                                                       | `bool`   | `false`                                   | no       |
| receive_wait_time_seconds             | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds).                                                                                      | `number` | `null`                                    | no       |
| redrive_allow_policy                  | The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs.                                                                                                                                                   | `any`    | `{}`                                      | no       |
| redrive_policy                        | The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5")                                                                 | `any`    | `{}`                                      | no       |
| sqs_managed_sse_enabled               | Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys                                                                                                                                    | `bool`   | `true`                                    | no       |
| create_queue_policy                   | Whether to create SQS queue policy                                                                                                                                                                                                  | `bool`   | `false`                                   | no       |
| source_queue_policy_documents         | List of IAM policy documents that are merged together into the exported document. Statements must have unique sids                                                                                                                  | `any`    | `[]`                                      | no       |
| override_queue_policy_documents       | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank sids will override statements with the same sid                                                             | `any`    | `[]`                                      | no       |
| queue_policy_statements               | A map of IAM policy statements for custom permission usage                                                                                                                                                                          | `any`    | `{}`                                      | no       |
| create_dlq                            | Determines whether to create SQS dead letter queue                                                                                                                                                                                  | `bool`   | `false`                                   | no       |
| dlq_content_based_deduplication       | Enables content-based deduplication for FIFO queues                                                                                                                                                                                 | `bool`   | `null`                                    | no       |
| dlq_deduplication_scope               | Specifies whether message deduplication occurs at the message group or queue level                                                                                                                                                  | `string` | `null`                                    | no       |
| dlq_delay_seconds                     | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)                                                                                                           | `number` | `null`                                    | no       |
| dlq_kms_data_key_reuse_period_seconds | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours) | `number` | `null`                                    | no       |
| dlq_kms_master_key_id                 | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK                                                                                                                                                   | `string` | `null`                                    | no       |
| dlq_message_retention_seconds         | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)                                                                                                           | `number` | `null`                                    | no       |
| dlq_name                              | This is the human-readable name of the queue. If omitted, Terraform will assign a random name                                                                                                                                       | `string` | `null`                                    | no       |
| dlq_receive_wait_time_seconds         | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)                                                                                       | `number` | `null`                                    | no       |
| create_dlq_redrive_allow_policy       | Determines whether to create a redrive allow policy for the dead letter queue.                                                                                                                                                      | `bool`   | `true`                                    | no       |
| dlq_redrive_allow_policy              | The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs.                                                                                                                                                   | `any`    | `{}`                                      | no       |
| dlq_sqs_managed_sse_enabled           | Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys                                                                                                                                    | `bool`   | `true`                                    | no       |
| dlq_fifo_throughput_limit             | Specifies whether the Dead Letter Queue FIFO queue throughput quota applies to the entire queue or per message group                                                                                                                | `string` | `null`                                    | no       |
| dlq_visibility_timeout_seconds        | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)                                                                                                                                                         | `number` | `null`                                    | no       |
| dlq_tags                              | A mapping of additional tags to assign to the dead letter queue                                                                                                                                                                     | `any`    | `{}`                                      | no       |
| create_dlq_queue_policy               | Whether to create SQS queue policy                                                                                                                                                                                                  | `bool`   | `false`                                   | no       |
| source_dlq_queue_policy_documents     | List of IAM policy documents that are merged together into the exported document. Statements must have unique sids                                                                                                                  | `any`    | `[]`                                      | no       |
| override_dlq_queue_policy_documents   | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank sids will override statements with the same sid                                                             | `any`    | `[]`                                      | no       |
| dlq_queue_policy_statements           | A map of IAM policy statements for custom permission usage                                                                                                                                                                          | `any`    | `{}`                                      | no       |







## ⚠️ Important Notes
- **⚠️ Recreate Existing Queue:** Recreates the existing queue if the queue type is changed - set `fifo_queue = true`
- **⚠️ FIFO Queue Compatibility:** When using SQS FIFO queues, the SNS topic must also be configured for FIFO compatibility



---

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la

## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 