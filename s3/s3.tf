
// This is a resource. The resource type is aws_s3_bucket and bucket_list
// is the TF identifier. "fakayu-bucket-list" is the unique bucket name on
// AWS S3 ... That's it
resource "aws_s3_bucket" "bucket_list" {
  bucket = "fakayu-bucket-list"
}
// By the way the
// resource "aws_s3_bucket" "..." {}
// is called a "Block" in HCL https://www.terraform.io/docs/language/syntax/configuration.html