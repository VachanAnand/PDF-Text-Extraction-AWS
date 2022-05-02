######################################################################
# S3 
######################################################################

resource "aws_s3_bucket" "s3_pdf_landing" {
    bucket = var.s3_pdf_landing_bucket_name
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_pdf_landing.id

  queue {
    queue_arn = aws_sqs_queue.sqs_landing.arn
    events = ["s3:ObjectCreated:*"]
  }
}


resource "aws_s3_bucket" "s3_pdf_extraction_results" {
    bucket = var.s3_pdf_extraction_name
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }
}