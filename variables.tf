/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* SQS | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "sqs_parameters" {
  type        = any
  description = ""
  default     = {}
}

variable "sqs_defaults" {
  type        = any
  description = ""
  default     = {}
}

/*----------------------------------------------------------------------*/
/* SQS | Alerts | Variable Definition                                   */
/*----------------------------------------------------------------------*/

variable "aws_sns_topic_alerts" {
  description = ""
  type        = string
  default     = ""
}