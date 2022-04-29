######################################################################
# SQS 
######################################################################

resource "aws_sqs_queue" "sqs_landing" {
    name = var.sqs_landing_name
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.sqs_landing_dlq.arn
        maxReceiveCount = 5
    })
    depends_on = [aws_sqs_queue.sqs_landing_dlq]
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }
}

resource "aws_sqs_queue" "sqs_landing_dlq" {
    name = var.dlq_landing_name
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }  
}

######################################################################
# SQS QUE POLICY
######################################################################
resource "aws_sqs_queue_policy" "sqs_landing_policy" {
    queue_url = aws_sqs_queue.sqs_landing.id
    policy = jsonencode({
        Version = "2012-10-17",
        Id = "sqspolicy",
        Statement = [
            {
                Sid = "First",
                Effect = "Allow",
                Principal = "*",
                Action = "sqs:SendMessage",
                Resource = ["${aws_sqs_queue.sqs_landing.arn}"],
                Condition = {
                    ArnEquals = {
                        "aws:SourceArn" = "${aws_s3_bucket.s3_pdf_landing.arn}"
                    }
                }
            }
        ]
    })
}