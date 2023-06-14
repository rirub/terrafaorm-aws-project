resource "aws_wafv2_ip_set" "ip_blacklist" {
  name               = "ip-blacklist"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["11.22.333.444/32"]
}

resource "aws_wafv2_web_acl" "firewall" {
  name = "firewall"

  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "ip-blacklist"
    priority = 1

    action {
      block {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ip_blacklist.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlacklistedIP"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "Allowed"
    sampled_requests_enabled   = true
  }
}