resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false #keeping it as false to delete while practising

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }

 tags = merge (
                    {
                        Name = "${var.project}-${var.environment}"
                    },
                local.common_tags)
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend_alb
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "fixed_response"
    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi, I am from HTTP backend ALB<h1>"
      status_code  = "200"
    }

  }
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.backend_alb.dns.name
    zone_id                = aws_lb.backend_alb.zone_id
    evaluate_target_health = true
  }
}