# ------------------------------------------------------------------------------
# Create the DynamoDB table that will be used for the Terraform state
# locking.
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "tf_dynamodb" {
  # We can't perform this action until our policy is in place.
  depends_on = [
    aws_iam_role_policy_attachment.provisionbackend_policy_attachment,
  ]

  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key       = "LockID"
  name           = var.dynamodb_table_name
  read_capacity  = var.dynamodb_table_read_capacity
  write_capacity = var.dynamodb_table_write_capacity
}