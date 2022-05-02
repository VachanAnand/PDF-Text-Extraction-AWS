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

resource "aws_sqs_queue" "sqs_textract" {
    name = var.sqs_textract_name
    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.sqs_textract_dlq.arn
        maxReceiveCount = 5
    })
    depends_on = [aws_sqs_queue.sqs_textract_dlq]
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }
}

resource "aws_sqs_queue" "sqs_textract_dlq" {
    name = var.dlq_textract_name
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

resource "aws_sqs_queue_policy" "sqs_textract_policy" {
    queue_url = aws_sqs_queue.sqs_textract.id
    policy = jsonencode({
        Version = "2012-10-17",
        Id = "sqspolicy",
        Statement = [
            {
                Sid = "First",
                Effect = "Allow",
                Principal = "*",
                Action = "sqs:SendMessage",
                Resource = ["${aws_sqs_queue.sqs_textract.arn}"],
                Condition = {
                    ArnEquals = {
                        "aws:SourceArn" = "${aws_sns_topic.sns_topic.arn}"
                    }
                }
            }
        ]
    })
}