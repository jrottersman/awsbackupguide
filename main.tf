resource "aws_kms_key" "example" {
  description = "example KMS key for backup vault. NOTE needs a policy if you are doing this for real"
}

resource "aws_backup_vault" "example" {
  name        = "example_backup_vault"
  kms_key_arn = aws_kms_key.example.arn
}

