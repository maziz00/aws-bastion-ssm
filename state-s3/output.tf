# Output the key pair name
output "key_pair_name" {
  value       = aws_key_pair.bastion-key-pair.key_name
  description = "The name of the key pair used for EC2 instances."
}

# Output the S3 bucket name
output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "The name of the S3 bucket used to store Terraform state files."
}