######################################################################
# TAGS 
######################################################################

environment = "vachan-dev"
creator = "vachan-Vachan-terraform"
project = "pdf-text-extraction"

######################################################################
# LANDING 
######################################################################

s3_pdf_landing_bucket_name = "pdf-text-extraction-landing"
sqs_landing_name = "sqs-pdf-landing-notification"
dlq_landing_name = "dlq-pdf-landing-notification"
lambda_pymupdf_name = "lambda-pymupdf-extraction"
iam_lambda_name = "iam-lambda-pdf-extraction"
iam_policy_lambda_name = "iam-lambda-policy"
iam_policy_lambda_logs_name = "iam-lambda-logs-policy"
ecr_pymupdf_name = "demo/pymupdf"
ecr_textract_name = "demo/textract"