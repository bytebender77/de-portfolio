output "bucket" { value = aws_s3_bucket.lake.bucket }
output "glue_database" { value = aws_glue_catalog_database.this.name }
output "athena_workgroup" { value = aws_athena_workgroup.this.name }
output "dbt_role_arn" { value = aws_iam_role.dbt.arn }
output "athena_staging_dir" { value = "s3://${aws_s3_bucket.lake.bucket}/athena-results/" }
