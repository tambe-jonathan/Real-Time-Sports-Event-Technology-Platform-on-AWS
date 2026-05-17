resource "aws_lambda_function" "this" {

filename="lambda.zip"

function_name=var.function_name

handler="lambda_function.lambda_handler"

runtime="python3.11"

role=var.lambda_role

source_code_hash=filebase64sha256("lambda.zip")

}
