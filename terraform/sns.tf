######################################################################
# SNS 
######################################################################

resource "aws_sns_topic" "sns_topic" {
    name = var.sns_name
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }
}

resource "aws_sns_topic_subscription" "sns_textract_sqs_target" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_textract.arn
}