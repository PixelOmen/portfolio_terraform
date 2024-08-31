resource "aws_iam_role_policy_attachment" "github_policy_attachment_cf_invalidation" {
  role       = var.github_openid_role_name
  policy_arn = aws_iam_policy.cf_invalidation_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_policy_attachment_ecr_push" {
  role       = var.github_openid_role_name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_policy_attachment_run_migration_task" {
  role       = var.github_openid_role_name
  policy_arn = aws_iam_policy.run_migration_task_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_policy_attachment_update_cluster_service" {
  role       = var.github_openid_role_name
  policy_arn = aws_iam_policy.update_cluster_service_policy.arn
}

resource "aws_iam_role_policy_attachment" "github_policy_attachment_bucket_push" {
  role       = var.github_openid_role_name
  policy_arn = aws_iam_policy.bucket_push_policy.arn
}
