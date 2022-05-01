# ######################################################################
# # SNS 
# ######################################################################

# resource "aws_sns_topic" "sns_topic" {
#     name = var.sns_name
#     tags = {
#         environment = var.environment
#         creator = var.creator
#         project = var.project
#     }
# }

# resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
#     topic_arn = aws_sns_topic.sns_topic.arn
#     protocol  = "sqs"
#     endpoint  = aws_sqs_queue.sqs_db.arn
# }

# resource "aws_sns_topic_subscription" "sns_datalake_subscription" {
#     topic_arn = aws_sns_topic.sns_topic.arn
#     protocol  = "sqs"
#     endpoint  = aws_sqs_queue.sqs_dl.arn
# }
