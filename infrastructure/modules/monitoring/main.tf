resource "aws_cloudwatch_log_group" "ecs" {

name="/ecs/eventpulse"

retention_in_days=30

}

resource "aws_sns_topic" "alerts" {

name="eventpulse-alerts"

}
