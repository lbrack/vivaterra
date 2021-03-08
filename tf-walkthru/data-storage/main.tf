
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
  region = var.region
  tags = {
    type="LOG"
    tier="STANDARDS"
  }
}