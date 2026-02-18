resource "aws_iam_role" "nginx_s3_role" {
  name = "${var.project_name}-s3-readonly-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_read_policy" {
  name = "${var.project_name}-s3-read-policy"
  role = aws_iam_role.nginx_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["s3:GetObject", "s3:ListBucket"]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.nginx_bucket.arn}",
          "${aws_s3_bucket.nginx_bucket.arn}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_instance_profile" "nginx_profile" {
  name = "${var.project_name}-nginx-instance-profile"
  role = aws_iam_role.nginx_s3_role.name
}