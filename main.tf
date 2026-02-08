# --- S3 bucket (application bucket, NOT terraform state bucket) ---
resource "aws_s3_bucket" "app" {
  bucket = var.bucket_name

  tags = {
    Name = "${var.name_prefix}-bucket"
  }
}

resource "aws_s3_bucket_versioning" "app" {
  bucket = aws_s3_bucket.app.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# --- Security group for instance (basic) ---
resource "aws_security_group" "web" {
  name        = "${var.name_prefix}-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-sg"
  }
}

data "aws_vpc" "default" {
  default = true
}

# --- EC2 instance ---
resource "aws_instance" "vm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids  = [aws_security_group.web.id]

  # only set key_name if provided
  key_name = var.key_name != "" ? var.key_name : null

  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}
