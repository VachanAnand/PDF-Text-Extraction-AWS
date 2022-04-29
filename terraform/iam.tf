######################################################################
# IAM 
######################################################################

resource "aws_iam_role" "iam_lambda" {
  name = var.iam_lambda_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
  tags = {
      environment = var.environment
      creator = var.creator
      project = var.project
  }
}

resource "aws_iam_role_policy" "iam_policy_lambda" {
  name = var.iam_policy_lambda_name
  role = aws_iam_role.iam_lambda.id
    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1647603180830",
        "Action": "s3:*",
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::pdf-text-extraction-landing/*"
      },
      {
        "Sid": "Stmt1647603239834",
        "Action": "*",
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Sid": "",
        "Action": "s3:*",
        "Effect": "Allow",
        "Resource": "*"
      }    
    ]
  })
}



resource "aws_iam_role_policy" "iam_policy_lambda_logs" {
  name = var.iam_policy_lambda_logs_name
  role = aws_iam_role.iam_lambda.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}