resource "aws_lb" "this" {

name=var.alb_name

internal=false

load_balancer_type="application"

security_groups=var.security_groups

subnets=var.subnets

}
