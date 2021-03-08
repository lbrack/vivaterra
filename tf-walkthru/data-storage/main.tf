
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
    enabled = true
    mfa_delete = false
  }
}

resource "aws_s3_bucket_object" "readme_file" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "files/README.md"
  source = "README.md"
}