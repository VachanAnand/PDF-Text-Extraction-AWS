######################################################################
# TAGS 
######################################################################

environment = "Vachan-dev"
creator = "Vachan-terraform"
project = "pdf-text-extraction"

######################################################################
# LANDING 
######################################################################

s3_pdf_landing_bucket_name = "pdf-text-extraction-landing"
s3_pdf_extraction_name = "pdf-text-extraction-results"
sns_name = "AmazonTextract-sns"
sqs_landing_name = "sqs-pdf-landing-notification"
dlq_landing_name = "dlq-pdf-landing-notification"
sqs_textract_name = "sqs-pdf-textract-notification"
dlq_textract_name = "dlq-pdf-textract-notification"
lambda_pymupdf_name = "lambda-pymupdf-extraction"
lambda_textract_name = "lambda-textract-extraction"
iam_lambda_name = "iam-lambda-pdf-extraction"
iam_textract_name = "iam-textract-pdf-extraction"
iam_policy_lambda_name = "iam-lambda-policy"
iam_policy_textract_name = "iam-textract-policy"
iam_policy_lambda_logs_name = "iam-lambda-logs-policy"
ecr_pymupdf_name = "demo/pymupdf"
ecr_textract_name = "demo/textract"