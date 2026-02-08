output "bucket_name" {
  value = aws_s3_bucket.app.bucket
}

output "instance_id" {
  value = aws_instance.vm.id
}

output "public_ip" {
  value = aws_instance.vm.public_ip
}
