resource "aws_iam_policy" "github_openid_role_policy" {
  name        = "${var.prefix}-github-openid-role-policy-${var.environment}"
  description = "Policy to allow invalidation of cloudfront cache"
  policy      = data.aws_iam_policy_document.github_openid_role_document.json

  tags = {
    Name        = "${var.prefix}-github-openid-role-policy-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "github_openid_role_policy_attachment" {
  role       = var.github_openid_role_name
  policy_arn = aws_iam_policy.github_openid_role_policy.arn
}
