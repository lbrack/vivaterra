
// This is a resource. The resource type is aws_s3_bucket and bucket_list
// is the TF identifier. "fakayu-bucket-list" is the unique bucket name on
// AWS S3
resource "aws_s3_bucket" "bucket_list" {
  bucket = "fakayu-bucket-list"
//  region = "us-west-2"
}