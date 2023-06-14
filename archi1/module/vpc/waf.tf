# resource "aws_wafv2_web_acl" "waf" {
#   name        = "example-waf"
#   description = "Example WAF"

#   scope = "REGIONAL"

#   default_action {
#     allow {}
#   }

#   rule {
#     name     = "example-rule"
#     priority = 1

#     action {
#       block {}
#     }

#     statement {
#       rule_group_reference_statement {
#         arn = "arn:aws:wafv2:us-west-2:123456789012:regional/rulegroup/example-rulegroup"  # 알맞은 WAF Rule Group ARN으로 변경하세요
#       }
#     }
#   }
# }

# # WAF 리소스와 ALB 연결
# resource "aws_wafv2_web_acl_association" "example" {
#   resource_arn = aws_subnet.example.arn  # ALB 리소스 아닌 경우 변경 필요
#   web_acl_arn  = aws_wafv2_web_acl.example.arn
# }






