resource "aws_dynamodb_table" "scores" {

name=var.table_name

billing_mode="PAY_PER_REQUEST"

hash_key="athlete"

attribute {

name="athlete"

type="S"

}

}
