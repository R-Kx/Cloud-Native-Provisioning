resource "random_id" "s3_bucket_id" {
	byte_length = 4
}

resource "aws_s3_bucket" "nginx_bucket" {
	bucket               = "s3-bucket-${random_id.s3_bucket_id.hex}"
	force_destroy        = true
	#object_lock_enabled = true
}

resource "aws_s3_bucket_ownership_controls" "nginx_bucket_ownership_controls" {
	bucket = aws_s3_bucket.nginx_bucket.id
	rule {
	  object_ownership = "BucketOwnerPreferred"
	}
}

resource "aws_s3_bucket_acl" "nginx_bucket_acl" {
	depends_on = [aws_s3_bucket_ownership_controls.nginx_bucket_ownership_controls]
	bucket     = aws_s3_bucket.nginx_bucket.id
	acl        = "private"
}

resource "aws_s3_bucket_versioning" "bucket_version" {
	bucket = aws_s3_bucket.nginx_bucket.id
	versioning_configuration {
	  status = "Enabled"
	}
}

resource "aws_s3_object" "bucket_object"	{
	depends_on = [aws_s3_bucket_versioning.bucket_version]

	key           = "index.html"
	bucket        = aws_s3_bucket.nginx_bucket.id
	source        = "index.html"
	content_type  = "text/html"
	force_destroy = true

	#object_lock_legal_hold_status = "ON"
	#object_lock_mode              = "GOVERNANCE"
	#object_lock_retain_until_date = "2026-02-16T03:59:60Z"
}
