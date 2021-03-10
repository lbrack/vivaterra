
// Remember that vars are defined in variables.tf
provider "aws" {
  region = var.region
}

// This is data collector which will be used to dynamically
// fetch the account ID to uniquely identify the bucket
// Remember that bucket names have to be unique in AWS
data "aws_caller_identity" "my_account" {

}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "vivaterra-tutorial-${data.aws_caller_identity.my_account.account_id}"

  acl = "public-read"

  // As of AWS Provider v3, the bucket region has to match the provider region (above)
  // thus commenting out the setting below will result in the following error
  //Error: Computed attributes cannot be set
  //
  //  on main.tf line 15, in resource "aws_s3_bucket" "my_bucket":
  //  15:   region = "us-west-2"
  //
  //Computed attributes cannot be set, but a value was set for "region".

  //region = "us-west-2"
  tags = {
    type = "LOG"
    tier = "STANDARDS"
  }
  versioning {
    enabled    = true
    mfa_delete = false
  }
  // The following defines the lifecyle of all the files under files/
  // After 30 days, they go to standard Infrequent Access
  // After 60 days, they go to Glacier
  // After 90 days, they are deleted
  lifecycle_rule {
    prefix  = "files/"
    enabled = true

    noncurrent_version_transition {
      storage_class = "STANDARD_IA"
      days          = 30
    }
    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }
    noncurrent_version_expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  // policy = file("bucket_policy.json") // Defining the bucket policy in a file.
  // heredoc formatting
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "MyBucketPolicy",
    "Statement": [
      {
        "Sid": "IPAllow",
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.my_bucket.bucket}/*",
        "condition": {
          "IpAddress": {"aws:SourceIP": "4.4.4.4/32"}
        }
      }
    ]
  }
  POLICY
}

resource "aws_s3_bucket_object" "readme_file" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "files/README.md"
  source = "README.md"
  // This forces terraform to compute the MD5 on the file to
  // update versioning
  etag = filemd5("README.md")
}