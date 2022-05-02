######################################################################
# LAMBDA 
######################################################################

resource "aws_lambda_function" "lambda_pymupdf_extraction" {
    function_name = var.lambda_pymupdf_name
    image_uri = "464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/demo/pymupdf:test"
    package_type = "Image"
    role = aws_iam_role.iam_lambda.arn
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
        version = "v1"
    }
}

resource "aws_lambda_event_source_mapping" "lambda_pymupdf_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_landing.arn
  function_name = aws_lambda_function.lambda_pymupdf_extraction.arn
}

resource "aws_lambda_function" "lambda_textract_extraction" {
    function_name = var.lambda_textract_name
    image_uri = "464866296249.dkr.ecr.ap-southeast-2.amazonaws.com/demo/textract:test"
    package_type = "Image"
    role = aws_iam_role.iam_lambda.arn
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }
}

resource "aws_lambda_event_source_mapping" "lambda_textract_event_mapping" {
  event_source_arn = aws_sqs_queue.sqs_textract.arn
  function_name = aws_lambda_function.lambda_textract_extraction.arn
}