provider "aws" {
    region = "us-east-2"
}

# We need to create an IAM user so we can attach the policy to it
resource "aws_iam_user" "user" {
    name = "TerraformUser"
}

# Next we will use the policy which we created via the AWS IAM console
resource "aws_iam_policy" "customPolicy" {
    name = "GlacierEc2Efs"

    # We are using EOF to write the JSON policy here
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:DescribeBackupPolicy",
                "elasticfilesystem:DeleteAccessPoint",
                "glacier:AbortMultipartUpload",
                "elasticfilesystem:DescribeReplicationConfigurations",
                "elasticfilesystem:PutAccountPreferences",
                "elasticfilesystem:DeleteReplicationConfiguration",
                "elasticfilesystem:DescribeAccountPreferences",
                "glacier:ListParts",
                "elasticfilesystem:CreateReplicationConfiguration",
                "elasticfilesystem:ClientMount",
                "glacier:PurchaseProvisionedCapacity",
                "elasticfilesystem:ModifyMountTargetSecurityGroups",
                "glacier:InitiateJob",
                "glacier:ListTagsForVault",
                "glacier:DeleteVault",
                "ec2:CreateTags",
                "glacier:DeleteArchive",
                "elasticfilesystem:CreateMountTarget",
                "glacier:ListMultipartUploads",
                "glacier:SetVaultNotifications",
                "glacier:CompleteMultipartUpload",
                "glacier:UploadMultipartPart",
                "elasticfilesystem:ClientRootAccess",
                "glacier:ListVaults",
                "elasticfilesystem:DeleteFileSystem",
                "ec2:DeleteTags",
                "elasticfilesystem:CreateFileSystem",
                "elasticfilesystem:ListTagsForResource",
                "glacier:CreateVault",
                "elasticfilesystem:ClientWrite",
                "glacier:DeleteVaultNotifications",
                "glacier:ListJobs",
                "elasticfilesystem:DescribeLifecycleConfiguration",
                "glacier:InitiateMultipartUpload",
                "elasticfilesystem:DescribeFileSystemPolicy",
                "elasticfilesystem:PutLifecycleConfiguration",
                "glacier:UploadArchive",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:DeleteMountTarget",
                "elasticfilesystem:CreateAccessPoint",
                "elasticfilesystem:DescribeMountTargets",
                "elasticfilesystem:Restore",
                "elasticfilesystem:DescribeAccessPoints",
                "elasticfilesystem:DescribeTags",
                "elasticfilesystem:Backup",
                "elasticfilesystem:PutBackupPolicy",
                "glacier:ListProvisionedCapacity",
                "elasticfilesystem:DescribeMountTargetSecurityGroups",
                "elasticfilesystem:UpdateFileSystem"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# Now let's attach the policy to the user
resource "aws_iam_policy_attachment" "policyBind" {
    name = "attachment"

    users = [aws_iam_user.user.name]
    policy_arn = aws_iam_policy.customPolicy.arn
}