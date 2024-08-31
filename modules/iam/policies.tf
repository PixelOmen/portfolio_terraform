resource "aws_iam_policy" "cf_invalidation_policy" {
  name        = "${var.prefix}-cf-createinvalidation-policy-${var.environment}"
  description = "Policy to allow invalidation of cloudfront cache"
  policy      = data.aws_iam_policy_document.cf_invalidation_document.json

  tags = {
    Name        = "${var.prefix}-cf-createinvalidation-policy-${var.environment}"
    Environment = var.environment
  }
}
