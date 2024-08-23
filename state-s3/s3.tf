resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-prod"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Locking Table"
  }
}

# Create a key pair
resource "aws_key_pair" "bastion-key-pair" {
  key_name   = "bastion-prod"
  public_key = file("${path.module}/id_rsa_bastion.pub")
}