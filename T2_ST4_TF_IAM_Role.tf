###########################################################
# IAM Role to provide ECRFullAccess to Jenkins & App Host #
###########################################################
resource "aws_iam_role" "ecr_access_role" {
  name = "Course-Project-ECR-Access"
  assume_role_policy = "${file("T2_ST4_AssumeRolePolicy.json")}"
}

resource "aws_iam_instance_profile" "course_profile" {
  name = "Course-Project-IAM-Profile"
  role = "${aws_iam_role.ecr_access_role.name}"
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name = "Course-Project-IAM-AttachPolicy"
  roles = ["${aws_iam_role.ecr_access_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
