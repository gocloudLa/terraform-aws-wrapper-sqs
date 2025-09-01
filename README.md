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
| [terraform-aws-modules/sqs/aws](https://github.com/terraform-aws-modules/sqs-aws) | 5.0.0 |



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










## ⚠️ Important Notes
- **⚠️ Recreate Existing Queue:** Recreates the existing queue if the queue type is changed - set `fifo_queue = true`



---

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la
- 🐛 **Issues**: [GitHub Issues](https://github.com/gocloudLa/issues)

## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 