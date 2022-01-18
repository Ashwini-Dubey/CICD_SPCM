###########################################
#S3 Bucket Initialization using Terraform.#
###########################################
resource "aws_s3_bucket" "bucket" {
  bucket = "se-ashwini"
  acl = "private"
}
