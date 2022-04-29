######################################################################
# TAGS 
######################################################################

variable environment {
  type        = string
  default     = "dev"
}

variable creator {
  type        = string
  default     = "vachan"
}

variable project {
  type        = string
  default     = "pdf-text-extraction"
}

######################################################################
# demo VARIABLES
######################################################################

variable s3_pdf_landing_bucket_name {
  type        = string
  default     = "pdf-text-extraction-landing"
}

variable sqs_landing_name {
  type        = string
  default     = "sqs-pdf-landing-notification"
}

variable dlq_landing_name {
  type        = string
  default     = "dlq-pdf-landing-notification"
}

variable lambda_pymupdf_name {
  type        = string
  default     = "lambda-pymupdf-extraction"
}

variable iam_lambda_name {
  type        = string
  default     = "iam-lambda-pdf-extraction"
}

variable iam_policy_lambda_name {
  type        = string
  default     = "iam-lambda-policy"
}

variable iam_policy_lambda_logs_name {
  type        = string
  default     = "iam-lambda-logs-policy"
}

variable ecr_pymupdf_name {
  type        = string
  default     = "demo/pymupdf"
}

variable ecr_textract_name {
  type        = string
  default     = "demo/textract"
}
