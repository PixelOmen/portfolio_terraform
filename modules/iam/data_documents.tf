# Used inline in the execution and task roles (assume_role_policy)
data "aws_iam_policy_document" "ecs_tasks_assume_role_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Used inline in the execution role definition
data "aws_iam_policy_document" "ecs_tasks_execution_document" {
  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    resources = [
      "arn:aws:ecr:${var.region}:${var.account_id}:repository/*",
    ]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${var.env_bucket_arn}/*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:${var.prefix}/${var.environment}/ecs/*:*",
    ]
  }
}

# Used inline in django_api_task_role definition
data "aws_iam_policy_document" "media_bucket_document" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      "${var.media_bucket_arn}",
      "${var.media_bucket_arn}/*",
    ]
  }
}

# Used inline in the cloudfront invalidation policy
data "aws_iam_policy_document" "cf_invalidation_document" {
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
    ]
    resources = [
      "arn:aws:cloudfront::${var.account_id}:distribution/${var.cf_distro_id}",
    ]
  }
}
