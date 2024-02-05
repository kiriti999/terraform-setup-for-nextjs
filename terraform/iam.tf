resource "aws_iam_role" "ec2_role" {
  name = "skillpact-ec2-role"

  # Assume role policy document
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "skillpact-admin-policy"

    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Action   = "*",
          Effect   = "Allow",
          Resource = "*",
        },
      ],
    })
  }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "skillpact-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}