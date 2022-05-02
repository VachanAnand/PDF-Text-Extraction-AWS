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

variable s3_pdf_extraction_name{
  type        = string
  default     = "pdf-text-extraction-results"
}

variable sns_name{
  type        = string
  default     = "sns-textract"
}

variable sqs_landing_name {
  type        = string
  default     = "sqs-pdf-landing-notification"
}

variable dlq_landing_name {
  type        = string
  default     = "dlq-pdf-landing-notification"
}


variable sqs_textract_name {
  type        = string
  default     = "sqs-pdf-textract-notification"
}

variable dlq_textract_name {
  type        = string
  default     = "dlq-pdf-textract-notification"
}

variable lambda_pymupdf_name {
  type        = string
  default     = "lambda-pymupdf-extraction"
}

variable lambda_textract_name {
  type        = string
  default     = "lambda-textract-extraction"
}

variable iam_lambda_name {
  type        = string
  default     = "iam-lambda-pdf-extraction"
}

variable iam_textract_name {
  type        = string
  default     = "iam-textract-pdf-extraction"
}

variable iam_policy_lambda_name {
  type        = string
  default     = "iam-lambda-policy"
}

variable iam_policy_textract_name {
  type        = string
  default     = "iam-textract-policy"
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

