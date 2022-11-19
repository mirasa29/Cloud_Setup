# create user for data engineer
resource "aws_iam_user" "iam-data-dev-user" {
  name = "data-dev-user"
  path = "/system/"
}

# pre-created aws policy for data engineer
data "aws_iam_policy" "data-dev-policy" {
  #name = "AWSDataPipeline_FullAccess"
  arn = "arn:aws:iam::aws:policy/AWSDataPipeline_FullAccess"
}

# policy to allow role assumption to be attached to target role
data "aws_iam_policy_document" "data-dev-assume-policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [ aws_iam_user.iam-data-dev-user.arn ]
      type        = "AWS"
    }
  }
}

# iam role that will assume role of data engineer
resource "aws_iam_role" "data-dev-role" {
  name  = "data-developer-role"
  path  = "/"
  assume_role_policy = data.aws_iam_policy_document.data-dev-assume-policy.json
}

# attach pre-created aws policy to role
resource "aws_iam_policy_attachment" "data-dev-attach-role" {
  name  = "aws-iam-role-data-dev-policy"
  roles = [ aws_iam_role.data-dev-role.name ]
  users = [ aws_iam_user.iam-data-dev-user.name ]
  policy_arn = data.aws_iam_policy.data-dev-policy.arn
}
