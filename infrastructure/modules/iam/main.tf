resource "aws_iam_role" "lambda_role" {

name=var.role_name

assume_role_policy=file("${path.module}/trust-policy.json")

}
