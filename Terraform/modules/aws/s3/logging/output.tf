output "arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}

output "id" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "bucket" {
  value = "${aws_s3_bucket.bucket.bucket}"
}

output "aws_address" {
  value = "${aws_s3_bucket.bucket.id}.s3.amazonaws.com"
}
