# Put our god-like IAM users in the godesses group.
resource "aws_iam_user_group_membership" "godess" {
  for_each = toset(var.godess_usernames)

  user = aws_iam_user.godess[each.key].name

  groups = [
    aws_iam_group.godess.name
  ]
}