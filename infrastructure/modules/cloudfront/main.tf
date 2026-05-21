resource "aws_cloudfront_distribution" "this" {

enabled=true

origin {

domain_name=var.origin_domain

origin_id="eventpulse"

}

default_cache_behavior {

allowed_methods=["GET","HEAD"]

cached_methods=["GET","HEAD"]

target_origin_id="eventpulse"

viewer_protocol_policy="redirect-to-https"

forwarded_values {

query_string=false

cookies {

forward="none"

}

}

}

restrictions {

geo_restriction {

restriction_type="none"

}

}

viewer_certificate {

cloudfront_default_certificate=true

}

}
