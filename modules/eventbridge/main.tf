resource "aws_cloudwatch_event_rule" "scores" {

name=var.rule_name

event_pattern=jsonencode({

source=["eventpulse"]

})

}
