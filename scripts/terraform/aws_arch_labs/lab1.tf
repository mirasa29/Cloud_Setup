resource "aws_s3_bucket" "bucket_0029" {
  bucket = var.bucket_name29

  tags = {
    Name        = var.bucket_name29
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_acl" "bucket29_acl" {
  bucket = aws_s3_bucket.bucket_0029.id
  acl    = "private"
}

resource "aws_s3_object" "object_img001" {
  bucket = aws_s3_bucket.bucket_0029.bucket
  key    = var.sample_file1
  source = var.file1_location
}