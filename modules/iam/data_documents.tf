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



# ------ Documents used for Policies attached to Github Actions OpenID Role ------

data "aws_iam_policy_document" "github_openid_role_document" {

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      "${var.env_bucket_arn}",
      "${var.env_bucket_arn}/*",
      "${var.staticfiles_bucket_arn}",
      "${var.staticfiles_bucket_arn}/*",
    ]
  }
  statement {
    actions = [
      "cloudfront:CreateInvalidation",
    ]
    resources = [
      "arn:aws:cloudfront::${var.account_id}:distribution/${var.cf_distro_id}",
    ]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:DescribeRepositories",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]
    resources = [
      "arn:aws:ecr:${var.region}:${var.account_id}:repository/${var.prefix}_${var.ecr_repo_name}_${var.environment}",
      "arn:aws:ecr:${var.region}:${var.account_id}:repository/${var.prefix}_${var.ecr_repo_name}_${var.environment}/*",
    ]
  }

  statement {
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTasks",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecs:RunTask",
    ]
    resources = [
      "arn:aws:ecs:${var.region}:${var.account_id}:task-definition/${var.prefix}_${var.migrate_task_name}_${var.environment}:*",
    ]
  }

  statement {
    actions = [
      "ecs:UpdateService",
    ]
    resources = [
      "arn:aws:ecs:${var.region}:${var.account_id}:service/${var.prefix}-${var.api_cluster_name}-${var.environment}",
    ]
  }

}
