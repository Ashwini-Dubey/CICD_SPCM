#############################################################
# Creating ECR Repository to push Docker Images for Node-App#
#############################################################
resource "aws_ecr_repository" "ecr-repo" {
  name = "course-project-node-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
