#=====================#
# Developer Group     #
#=====================#

resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/"
}

resource "aws_iam_group_membership" "developers" {
  name = "developers"

  users = [
    "${var.developers_users}",
  ]

  group = "${aws_iam_group.developers.name}"
}

resource "aws_iam_group_policy_attachment" "developer_readonly" {
  group      = "${aws_iam_group.developers.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "developer_cloudfront" {
  group      = "${aws_iam_group.developers.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}

resource "aws_iam_group_policy_attachment" "developer_mfa" {
  group      = "${aws_iam_group.developers.name}"
  policy_arn = "${aws_iam_policy.mfa_policy.arn}"
}

#=====================#
# DevOps Group        #
#=====================#

resource "aws_iam_group" "devops" {
  name = "devops"
  path = "/"
}

resource "aws_iam_group_membership" "devops" {
  name = "devops"

  users = [
    "${var.devops_users}",
  ]

  group = "${aws_iam_group.devops.name}"
}

resource "aws_iam_group_policy_attachment" "devops_full_access" {
  group      = "${aws_iam_group.devops.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#=====================#
# Backoffice Group    #
#=====================#

resource "aws_iam_group" "back_office" {
  name = "back-office"
  path = "/"
}

resource "aws_iam_group_membership" "back_office" {
  name = "back_office"

  users = [
    "${var.back_office_users}",
  ]

  group = "${aws_iam_group.back_office.name}"
}

resource "aws_iam_group_policy_attachment" "backoffice_read_only" {
  group      = "${aws_iam_group.back_office.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

#=====================#
# Administrator Group #
#=====================#

resource "aws_iam_group" "administrator" {
  name = "administrator"
  path = "/"
}

resource "aws_iam_group_membership" "administrator" {
  name = "administrator"

  users = [
    "${var.administrator_users}",
  ]

  group = "${aws_iam_group.administrator.name}"
}

resource "aws_iam_group_policy_attachment" "administrator_full_access" {
  group      = "${aws_iam_group.administrator.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "administrator_billing" {
  group      = "${aws_iam_group.administrator.name}"
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_group_policy_attachment" "administrator_iam" {
  group      = "${aws_iam_group.administrator.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

########################
# developers-mfa-policy #
#########################
resource "aws_iam_policy" "mfa_policy" {
  name   = "developers-mfa-policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.mfa_policy_document.json}"
}

data "aws_iam_policy_document" "mfa_policy_document" {
  "statement" {
    sid    = "AllowAllUsersToListAccounts"
    effect = "Allow"

    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
    ]

    resources = [
      "*",
    ]
  }

  "statement" {
    sid    = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  "statement" {
    sid    = "AllowIndividualUserToViewAndManageTheirOwnMFA"
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  "statement" {
    sid    = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:mfa/$${aws:username}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/$${aws:username}",
    ]

    condition {
      test     = "Bool"
      values   = ["aws:MultiFactorAuthPresent"]
      variable = "true"
    }
  }

  "statement" {
    effect = "Allow"

    actions = [
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ListUsers",
    ]

    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}
