# ------- Policies attached to Github Actions OpenID Role -------
resource "aws_iam_policy" "cf_invalidation_policy" {
  name        = "${var.prefix}-cf-createinvalidation-policy-${var.environment}"
  description = "Policy to allow invalidation of cloudfront cache"
  policy      = data.aws_iam_policy_document.cf_invalidation_document.json

  tags = {
    Name        = "${var.prefix}-cf-createinvalidation-policy-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "ecr_push_policy" {
  name        = "${var.prefix}-ecr-push-policy-${var.environment}"
  description = "Policy to allow pushing to ECR"
  policy      = data.aws_iam_policy_document.ecr_push_document.json

  tags = {
    Name        = "${var.prefix}-ecr-push-policy-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "run_migration_task_policy" {
  name        = "${var.prefix}-run-migration-task-policy-${var.environment}"
  description = "Policy to allow running the migration task"
  policy      = data.aws_iam_policy_document.run_migration_task_document.json

  tags = {
    Name        = "${var.prefix}-run-migration-task-policy-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "update_cluster_service_policy" {
  name        = "${var.prefix}-update-cluster-service-policy-${var.environment}"
  description = "Policy to allow updating the cluster service"
  policy      = data.aws_iam_policy_document.update_cluster_service_document.json

  tags = {
    Name        = "${var.prefix}-update-cluster-service-policy-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "bucket_push_policy" {
  name        = "${var.prefix}-bucket-push-policy-${var.environment}"
  description = "Policy to allow pushing to env and staticfiles buckets"
  policy      = data.aws_iam_policy_document.bucket_push_document.json

  tags = {
    Name        = "${var.prefix}-bucket-push-policy-${var.environment}"
    Environment = var.environment
  }
}
