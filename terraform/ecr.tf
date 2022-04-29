######################################################################
# ECR  
######################################################################

resource "aws_ecr_repository" "ecr_pymupdf" {
    name = var.ecr_pymupdf_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }  
}

resource "aws_ecr_repository" "ecr_textract" {
    name = var.ecr_textract_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }
    tags = {
        environment = var.environment
        creator = var.creator
        project = var.project
    }  
}

