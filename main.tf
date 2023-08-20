resource "aws_kms_key" "example" {
  description = "example KMS key for backup vault. NOTE needs a policy if you are doing this for real"
}

resource "aws_backup_vault" "example" {
  name        = "example_backup_vault"
  kms_key_arn = aws_kms_key.example.arn
}

data "aws_iam_policy" "backup_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role" "backup_service_role" {
  name = "backup_service_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "backup-attach" {
  role       = aws_iam_role.backup_service_role.name
  policy_arn = data.aws_iam_policy.backup_policy.arn
}

